
struct BeverageDTO : Identifiable , Codable {
    let id: Int
    let winery: String
    let wine: String
    let location: String
    let image: String
    let rating: Rating
}

struct Rating: Codable {
    let average: String
    let reviews: String
}
