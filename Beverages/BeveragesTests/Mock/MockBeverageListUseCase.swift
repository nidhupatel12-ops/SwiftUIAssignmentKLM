
import XCTest
@testable import Beverages

class MockBeverageListUseCase: BeverageListUseCase {
    
    func testBeverageListUseCase() async throws {
        
        let repository = MockBeverageRepository()
        repository.beverages = [BeverageDTO(id: 1, winery: "Test", wine: "Red Wine", location: "France", image: "", rating: Rating(average: "4.5", reviews: "80 ratings"))]
        let useCase = BeverageListUseCase(beverageRepository: repository)
        let result = try await useCase.execute()
        
        XCTAssertEqual(result.count, 1)
    }
   
    
    
}
