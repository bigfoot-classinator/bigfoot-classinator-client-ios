import PromiseKit

enum Classination: String {
    case classA = "Class A"
    case classB = "Class B"
    case classC = "Class C"
    case badClass = "Bad Class"
}

class Classinator {

    static let shared = Classinator()

    private var adapter = Adapter.shared

    func classinate(latitude: Double, longitude: Double, sighting: String) -> Promise<Classination> {
        return adapter.classinate(json: [ "latitude": latitude, "longitude": longitude, "sighting" : sighting ])
            .then { data -> Promise<Classination> in
                let selected = self.extractSelected(data: data)
                let classination = self.createClassination(selected: selected)
                return Promise<Classination>.value(classination)
            }
    }

    private func extractSelected(data: [String : Any]) -> String {
        let rawClassination = data["classination"] as? [String : Any]
        return rawClassination?["selected"] as? String ?? ""
    }

    private func createClassination(selected: String) -> Classination {
        return Classination.init(rawValue: selected) ?? .badClass
    }
}

class Messages {

    static let shared = Messages()

    func fetchMessage(classination: Classination) -> String {
        return Bundle.main.localizedString(forKey: classination.rawValue, value: nil, table: "Messages")
    }
}
