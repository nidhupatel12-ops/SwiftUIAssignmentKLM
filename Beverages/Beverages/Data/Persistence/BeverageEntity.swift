
import Foundation
import SwiftData

@Model
final class BeverageEntity: Hashable {
    @Attribute(.unique) var id : Int
    var wine : String
    var winery: String
    var location: String
    var image: String
    var rating: Rating
    
    init(from dto: BeverageDTO) {
        self.id = dto.id
        self.wine = dto.wine
        self.winery = dto.winery
        self.location = dto.location
        self.image = dto.image
        self.rating = dto.rating
    }
    
    func updateEntity(dto: BeverageDTO) {
        self.id = dto.id
        self.wine = dto.wine
        self.winery = dto.winery
        self.location = dto.location
        self.image = dto.image
        self.rating = dto.rating
    }
}




