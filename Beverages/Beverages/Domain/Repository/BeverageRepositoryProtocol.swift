
import Foundation

protocol BeverageRepositoryProtocol {
    func fetchBeverageList() async throws -> [BeverageDTO]
}
