
@testable import Beverages

final class MockBeverageRepository: BeverageRepositoryProtocol {
    var beverages: [BeverageDTO] = []
    
    func fetchBeverageList() async throws -> [BeverageDTO] {
        return beverages
    }
}
