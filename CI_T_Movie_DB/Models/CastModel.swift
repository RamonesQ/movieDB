import Foundation

struct CastData: Decodable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Decodable {
    let name: String
    let profilePath: String?
    let castID: Int?
    let character: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
    }
}
