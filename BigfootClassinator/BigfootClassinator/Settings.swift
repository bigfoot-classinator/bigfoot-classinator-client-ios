import Foundation

class Settings {

    static let shared = Settings()

    private var settingsList: [String : Any]!

    init() {
        let fileUrl = fetchSettingsFileUrl()
        let data = fetchSettingsData(forFile: fileUrl)
        let plist = parseSettingsData(forData: data)
        settingsList = plist ?? [:]
    }

    var classinationUrl: String {
        return "\(classinatorBaseUrl)\(classinatePath)"
    }

    var classinatorBaseUrl: String {
        guard let url = settingsList["CLASSINATOR_BASE_URL"] as? String else {
            fatalError("No CLASSINATOR_BASE_URL KEY in plist")
        }
        return url
    }

    var classinatePath: String {
        guard let url = settingsList["CLASSINATE_PATH"] as? String else {
            fatalError("No CLASSINATE_PATH KEY in plist")
        }
        return url
    }

    private func fetchSettingsFileUrl() -> URL {
        guard let fileUrl = Bundle.main.url(forResource: "Settings", withExtension: "plist") else {
            fatalError("Cannot find settings file")
        }
        return fileUrl
    }

    private func fetchSettingsData(forFile fileUrl: URL) -> Data {
        guard let data = try? Data(contentsOf: fileUrl) else {
            fatalError("Cannot load settings file")
        }
        return data
    }

    private func parseSettingsData(forData data: Data) -> [String : Any]? {
        guard let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] else {
            fatalError("Cannot parse settings file")
        }
        return plist
    }
}
