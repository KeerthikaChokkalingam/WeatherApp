//
//  ViewController.swift
//  Weather App
//
//  Created by Keerthika Chokkalingam on 08/09/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocationAuthorization()
        startLocationUpdates()
    }
    
    func requestLocationAuthorization() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    func startLocationUpdates() {
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
}

extension ViewController: CLLocationManagerDelegate {
   
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        var currentLocation: CLLocation?
        currentLocation = locationManager.location
        
        guard let currentLocation else { return }
        
        CLGeocoder().reverseGeocodeLocation(currentLocation) { [weak self] (placemarks, error) -> Void in
            if error != nil {
                return
            }else if let country = placemarks?.first?.country,
                     let city = placemarks?.first?.locality {
               print("\(city), \(country)")
            }
            else {
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("Latitude: \(latitude), Longitude: \(longitude)")
            // Handle the location data as needed
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
        // Handle the error as needed
    }
    
}
