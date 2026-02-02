
import Foundation
import SwiftData


final class AppContainer {
    
    let featchBeverageUseCase: BeverageListUseCase
    init(context: ModelContext) {
        let apiRequest = APIRequest()
        let beverageRepository = BeverageRepository(context: context, apiRequest: apiRequest)
        self.featchBeverageUseCase = BeverageListUseCase(beverageRepository: beverageRepository)
    }
}
