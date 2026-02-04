
import Foundation

public protocol APIManagerDelegate  {
    func networkGetRequest<T: Decodable>(_ url: URL?, type: T.Type) async throws -> T
}

public final class APIManager: APIManagerDelegate {
    static let shared = APIManager()
    
    public func networkGetRequest<T>(_ url: URL?, type: T.Type) async throws -> T where T : Decodable {
        guard let url = url else {
            throw AppError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw AppError.unknownError
            }
            
            guard let httpStatusCode = (response as? HTTPURLResponse)?.statusCode, (200..<300).contains(httpStatusCode) else {
                throw AppError.serverError(httpResponse.statusCode)
            }
            
            guard !data.isEmpty else {
                throw AppError.noData
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            }catch let error as AppError {
                throw error
            }
        } catch {
            throw AppError.unknownError
        }
    }
}
