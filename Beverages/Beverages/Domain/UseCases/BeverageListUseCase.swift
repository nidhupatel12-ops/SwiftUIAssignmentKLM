
import Foundation

class BeverageListUseCase {
    private let beverageRepository : BeverageRepositoryProtocol
    init(beverageRepository: BeverageRepositoryProtocol) {
        self.beverageRepository = beverageRepository
    }
    
    func execute() async throws -> [BeverageDTO] {
        try await beverageRepository.fetchBeverageList()
    }
}
