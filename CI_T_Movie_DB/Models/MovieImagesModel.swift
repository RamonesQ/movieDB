import Foundation


struct MovieImages: Decodable {
    let backdrops: [Backdrop]
    let id: Int
}

struct Backdrop: Decodable {
    let filePath: String?
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
