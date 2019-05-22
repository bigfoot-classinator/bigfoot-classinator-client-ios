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

        if !CLLocationManager.locationServicesEnabled() {
            fatalError("Location services must be enabled to use the Bigfoot Classinator.")
        }

        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .authorizedWhenInUse && authorizationStatus != .authorizedAlways {
            fatalError("Location services must be authorized to use the Bigfoot Classinator.")
        }

        // Configure and start the service.
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 50.0
        locationManager.delegate = self

        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last!
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            manager.stopUpdatingLocation()
        }
    }

    var latitude: Double {
        return lastLocation?.coordinate.latitude ?? 0.0
    }

    var longitude: Double {
        return lastLocation?.coordinate.longitude ?? 0.0
    }

}
