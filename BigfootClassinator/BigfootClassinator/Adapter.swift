import Alamofire
import PromiseKit

class Adapter {
    static let shared = Adapter()

    private var settings = Settings.shared

    func classinate(json: [String:Any]) -> Promise<[String:Any]> {
        return Alamofire
            .request(settings.classinationUrl, method: .post, parameters: json, encoding: JSONEncoding.default)
            .responseJSON()
            .then { response -> Promise<[String:Any]> in
                let rawData = response.json as? [String:Any] ?? [:]
                return Promise<[String:Any]>.value(rawData)
        }
    }
}
