
import XCTest
@testable import Beverages

final class APIManagerTests: XCTestCase {

    var mockAPIManager : MockAPIManager!
    
    override func setUpWithError() throws {
        super.setUp()
        mockAPIManager = MockAPIManager()
    }

    override func tearDownWithError() throws {
        mockAPIManager = nil
        try super.tearDownWithError()
    }

    func testNetworkRequestSucess() async throws {
        
        let beverage = BeverageDTO(id: 1, winery: "Test", wine: "Red Wine", location: "France", image: "", rating: Rating(average: "4.5", reviews: "80 ratings"))
        mockAPIManager.mockData = try JSONEncoder().encode(beverage)
        
        let result : BeverageDTO = try await mockAPIManager.networkGetRequest(URL(string: API.BeveragesURL), type: BeverageDTO.self)
            
        XCTAssertEqual(result.id, 1)
    }

    func testNetworkRequestFailure() async  {
        
        mockAPIManager.shouldReturnError = true
        mockAPIManager.mockerror = .inavalidUrl
        
        do {
            let _:BeverageDTO = try await mockAPIManager.networkGetRequest(nil, type: BeverageDTO.self)
            XCTFail("Invalid URL")
        }catch let error as AppError {
            XCTAssertEqual( error, .inavalidUrl)
        }catch {
            XCTFail("Unexcpected error")
        }
    }
}
