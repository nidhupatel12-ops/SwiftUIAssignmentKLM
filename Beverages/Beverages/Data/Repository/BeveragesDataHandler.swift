import Foundation
import SwiftData

@ModelActor
actor BeveragesDataHandler {
    
    func GetAndSave(dto: [BeverageDTO]) throws {
        let descriptor = FetchDescriptor<BeverageEntity>(sortBy: [SortDescriptor(\.id)])
        let localData = try modelContext.fetch(descriptor)
        for dt in dto {
            if let existing = localData.first(where: { $0.id == dt.id }) {
                existing.updateEntity(dto: dt)
            }else {
                modelContext.insert(BeverageEntity(from: dt))
            }
        }
        try modelContext.save()
    }
    
    func getLocalData() throws -> [BeverageEntity] {
        let descriptor = FetchDescriptor<BeverageEntity>(sortBy: [SortDescriptor(\.id)])
        return try modelContext.fetch(descriptor)
    }
}
