
import Foundation
struct Links : Codable {
	let selfUrl : String?
	let html : String?
    let photos : String?
	let download : String?

	enum CodingKeys: String, CodingKey {
		case selfUrl = "self"
		case html = "html"
        case photos = "photos"
		case download = "download"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        selfUrl = try values.decodeIfPresent(String.self, forKey: .selfUrl)
		html = try values.decodeIfPresent(String.self, forKey: .html)
        photos = try values.decodeIfPresent(String.self, forKey: .photos)
		download = try values.decodeIfPresent(String.self, forKey: .download)
	}

}
