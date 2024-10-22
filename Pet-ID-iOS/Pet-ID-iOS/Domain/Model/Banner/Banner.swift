import Foundation

struct Banner: Identifiable, Decodable {
    let id: Int
    let imageUrl: String?
    let text: String?
    let type: String?
    let status: String?
}
