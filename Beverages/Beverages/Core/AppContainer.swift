
import Foundation
import SwiftData

final class AppContainer {
    
    let fetchBeverageUseCase: BeverageListUseCase
    init(container: ModelContainer) {
        let apiRequest = APIRequest()
        let beverageRepository = BeverageRepository(container: container, apiRequest: apiRequest)
        self.fetchBeverageUseCase = BeverageListUseCase(beverageRepository: beverageRepository)
    }
}
