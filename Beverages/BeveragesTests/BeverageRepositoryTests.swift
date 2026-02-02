//
//  BeverageRepositoryTests.swift
//  BeveragesTests
//
//  Created by 01HW2318083 on 02/02/26.
//

import XCTest
import SwiftData
@testable import Beverages

@MainActor
final class BeverageRepositoryTests: XCTestCase {

    private var repository : BeverageRepository!
    var container: ModelContainer!
    var context: ModelContext!
    var mockNetwork: MockNetworkMonitor!
    private let apiRequest = APIRequest()
    
    override func setUpWithError() throws {
         super.setUp()
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: BeverageEntity.self, configurations: config)
        context = container.mainContext
        mockNetwork = MockNetworkMonitor()
        repository = BeverageRepository(context: context, apiRequest: apiRequest)
    }
    
   
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetBeverageList_Offline() async throws {
        let localItem = BeverageEntity(from: BeverageDTO(id: 1, winery: "Test", wine: "Red Wine", location: "France", image: "", rating: Rating(average: "4.5", reviews: "80 ratings")))
        context.insert(localItem)
        try context.save()
        mockNetwork.isReachable = false
        let fetchDescriptor = FetchDescriptor<BeverageEntity>()
        let result = try context.fetch(fetchDescriptor)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.wine, "Red Wine")
    }

}
