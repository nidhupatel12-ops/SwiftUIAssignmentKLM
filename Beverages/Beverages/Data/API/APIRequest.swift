
import Foundation

final class APIRequest {
    
    func getBeverageList() async throws -> [BeverageDTO] {
        let finalURL = URL(string: API.BeveragesURL)
        return try await APIManager.shared.networkGetRequest(finalURL, type: [BeverageDTO].self)
    }
}
