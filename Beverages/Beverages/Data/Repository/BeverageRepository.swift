
import Foundation
import SwiftUI
import SwiftData

class BeverageRepository: BeverageRepositoryProtocol {
    
    private let container: ModelContainer
    private let apiRequest: APIRequest
    private let networkMonitor: NetworkMonitorProtocol
    
    init(container: ModelContainer, apiRequest: APIRequest,
         networkMonitor: NetworkMonitorProtocol = NetworkMonitor()) {
        self.container = container
        self.apiRequest = apiRequest
        self.networkMonitor = networkMonitor
    }
    
    func fetchBeverageList() async throws -> [BeverageDTO] {
        let handler = BeveragesDataHandler(modelContainer: self.container)
        let isConnected = await networkMonitor.isConnectedToInternet()
        if isConnected {
            do {
                let responceData = try await apiRequest.getBeverageList()
                try await handler.GetAndSave(dto: responceData)
                return responceData
            }catch {
                print("API Error")
                throw AppError.noData
            }
        }else {
            let localData = try await handler.getLocalData()
            let beverageDTO: [BeverageDTO] = localData.map { beverageEntity in
                BeverageDTO(id: beverageEntity.id, winery: beverageEntity.winery, wine: beverageEntity.wine, location: beverageEntity.location, image: beverageEntity.image, rating: beverageEntity.rating)
            }
            return beverageDTO
        }
    }
    
}
