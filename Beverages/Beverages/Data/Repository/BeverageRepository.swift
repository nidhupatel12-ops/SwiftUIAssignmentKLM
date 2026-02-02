
import Foundation
import SwiftUI
import SwiftData

class BeverageRepository : BeverageRepositoryProtocol {
    
    private let context: ModelContext
    private let apiRequest : APIRequest
    
    
    init(context: ModelContext, apiRequest: APIRequest) {
        self.context = context
        self.apiRequest = apiRequest
    }
    
    func fetchBeverageList() async throws -> [BeverageDTO] {
    
        let descriptor = FetchDescriptor<BeverageEntity>(sortBy: [SortDescriptor(\.id)])
        let localData = try context.fetch(descriptor)
        
        if NetworkMonitor.shared.isReachable {
            do {
                let responceData = try await apiRequest.getBeverageList()
                for obj in responceData {
                    if let existing = localData.first(where: { $0.id == obj.id }) {
                        existing.updateEntity(dto: obj)
                    }else {
                        context.insert(BeverageEntity(from: obj))
                    }
                }
                try context.save()
                return responceData
            }catch {
                print("API Error")
                throw AppError.noData
            }
        }else {
            let beverageDTO : [BeverageDTO] = localData.map { beverageEntity in
                BeverageDTO(id: beverageEntity.id, winery: beverageEntity.winery, wine: beverageEntity.wine, location: beverageEntity.location, image: beverageEntity.image, rating: beverageEntity.rating)
            }
            return beverageDTO
        }
    }
    
}
