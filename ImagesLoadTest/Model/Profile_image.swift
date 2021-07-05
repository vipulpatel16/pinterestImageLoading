
import Foundation
struct Profile_image : Codable {
	let small : String?
	let medium : String?
	let large : String?

	enum CodingKeys: String, CodingKey {

		case small = "small"
		case medium = "medium"
		case large = "large"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		small = try values.decodeIfPresent(String.self, forKey: .small)
		medium = try values.decodeIfPresent(String.self, forKey: .medium)
		large = try values.decodeIfPresent(String.self, forKey: .large)
	}

}
