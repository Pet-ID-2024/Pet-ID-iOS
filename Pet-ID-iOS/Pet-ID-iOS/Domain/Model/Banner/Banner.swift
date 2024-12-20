import Foundation

struct Banner: Identifiable, Decodable {
    let id: Int
    var imageUrl: String?
    let text: String
    let type: String
    let status: String
}

enum BannerType: String {
    case main
    case content
}
