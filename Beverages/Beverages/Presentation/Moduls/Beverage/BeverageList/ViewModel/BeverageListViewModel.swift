
import Foundation
import SwiftUI

@MainActor
class BeverageListViewModel: ObservableObject {
    @Published var beverages: [BeverageDTO] = []
    @Published var isLoading: Bool = false
    @Published var networkError: AppError?
    
    private let beverageUseCase : BeverageListUseCase
    
    init(beverageUseCase: BeverageListUseCase) {
        self.beverageUseCase = beverageUseCase
    }
    
    func fetchBeverages() async {
        isLoading = true
        defer { isLoading = false }
        do {
            beverages = try await beverageUseCase.execute()
        }catch let error as AppError {
            self.networkError = error
        }catch {
            self.networkError = .unknownError
        }
    }
}
