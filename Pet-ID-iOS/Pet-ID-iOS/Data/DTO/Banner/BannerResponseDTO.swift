import Foundation

struct BannerResponseDTO: Decodable {
    let id: Int
    let imageUrl: String?
    let text: String?
    let type: String?
    let status: String?

    func toDomain() -> Banner {
        return Banner(
            id: self.id,
            imageUrl: self.imageUrl ?? "",
            text: self.text ?? "No text",
            type: self.type ?? "unknown",
            status: self.status ?? "active"
        )
    }
}
