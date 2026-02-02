
import Foundation
@testable import Beverages

final class MockAPIManager: APIManagerDelegate  {
    
    var shouldReturnError: Bool = false
    var mockerror: AppError = .unknownError
    var mockData : Data?
    
    func networkGetRequest<T : Decodable>(_ url: URL?, type: T.Type) async throws -> T {
        if shouldReturnError {
            throw mockerror
        }
        guard let data = mockData else {
            throw AppError.noData
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

