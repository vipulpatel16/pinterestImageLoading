import Foundation
import Alamofire

//"https://pastebin.com/raw/wgkJgazE"
class Environment {
    class func MainBasePath() -> String {
        return "https://pastebin.com/raw/"
    }
}

protocol Routable {
    var path                : String { get }
    var method              : HTTPMethod { get }
}

enum APIRouter: Routable {
    case getImages
}

extension APIRouter {
    var path: String {
        switch self {
        case .getImages:
            return Environment.MainBasePath() + "wgkJgazE"
        }
    }
}

extension APIRouter {
    var method: HTTPMethod {
        switch self {
        case .getImages:
            return .get
        }
    }
}

