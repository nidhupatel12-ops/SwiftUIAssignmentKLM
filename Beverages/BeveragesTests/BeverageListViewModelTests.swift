
import XCTest
@testable import Beverages

@MainActor
final class BeverageListViewModelTests: XCTestCase {

    func testBeverageListViewModel() async {
        let repo = MockBeverageRepository()
        repo.beverages = [BeverageDTO(id: 1, winery: "Test", wine: "Red Wine", location: "France", image: "", rating: Rating(average: "4.5", reviews: "80 ratings"))]
        let usecase = BeverageListUseCase(beverageRepository: repo)
        
        let viewModel = BeverageListViewModel(beverageUseCase: usecase)
        await viewModel.fetchBeverages()
        
        XCTAssertFalse(viewModel.beverages.isEmpty)
        
    }

}
