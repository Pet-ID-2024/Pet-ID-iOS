import Foundation

struct BannerResponseDTO: Decodable {
    let id: Int
    let imageUrl: String
    let text: String
    let type: String
    let status: String

    func toDomain() -> Banner {
        return Banner(
            id: self.id,
            imageUrl: self.imageUrl,
            text: self.text,
            type: self.type,
            status: self.status
        )
    }
}

struct PresignedURLResponseDTO: Decodable {
    let url: String
}
