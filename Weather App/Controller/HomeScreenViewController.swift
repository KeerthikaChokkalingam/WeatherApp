//
//  HomeScreenViewController.swift
//  Weather App
//
//  Created by Keerthika Chokkalingam on 08/09/23.
//

import UIKit
import CoreLocation

class HomeScreenViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocationAuthorization()
        startLocationUpdates()
    }
    
}

extension HomeScreenViewController {
    
    func requestLocationAuthorization() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startLocationUpdates() {
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func settingsPopUp() {
        let alertController = UIAlertController(
            title: "Location Services Disabled",
            message: "To use this feature, please enable location services for this app in Settings.",
            preferredStyle: .alert
        )
        let settingsAction = UIAlertAction(title: "Open Settings", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        }
        alertController.addAction(settingsAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension HomeScreenViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        var currentLocation: CLLocation!
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            currentLocation = locationManager.location
            guard let currentLocation else { return }
            CLGeocoder().reverseGeocodeLocation(currentLocation) { [self] (placemarks, error) -> Void in
                if error != nil {
                    return
                }else if let country = placemarks?.first?.country,
                         let city = placemarks?.first?.locality {
                    print("\(city), \(country)")
                }
                else {
                }
            }
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            settingsPopUp()
        case .denied:
            settingsPopUp()
        default:
            break
        }
    }
    
}
