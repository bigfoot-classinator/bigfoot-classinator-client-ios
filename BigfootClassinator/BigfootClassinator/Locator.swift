import PromiseKit
import CoreLocation

struct Location {
    var latitude: Float
    var longitude: Float
}

class Locator: NSObject, CLLocationManagerDelegate {

    static let shared = Locator()

    private let locationManager = CLLocationManager()
    private var lastLocation: CLLocation?

    override init() {
        super.init()
        startWatchingLocation()
    }

    var latitude: Double {
        return lastLocation?.coordinate.latitude ?? 0.0
    }

    var longitude: Double {
        return lastLocation?.coordinate.longitude ?? 0.0
    }

    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last!
    }

    private func startWatchingLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

}
