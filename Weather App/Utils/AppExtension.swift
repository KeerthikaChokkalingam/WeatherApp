//
//  AppExtension.swift
//  Weather App
//
//  Created by Keerthika Chokkalingam on 09/09/23.
//

import Foundation
import UIKit
import CoreLocation

class AppExtension {
    
}

extension Date {
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
        return localDate
    }
}

extension HomeScreenViewController {
    
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
    
    
    func requestLocationAuthorization() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startLocationUpdates() {
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func errorViewSetUp() {
        todayWeatherView.backgroundColor = .white
        topView.backgroundColor = .white
        bottomWholeView.backgroundColor = .white
        bottomLeftView.backgroundColor = .white
        bottomRightView.backgroundColor = .white
        bottomLeftWholeView.backgroundColor = .white
        bottomRightWholeView.backgroundColor = .white
        
        if let todayLabel = self.view.viewWithTag(20) as? UILabel {
            todayLabel.textColor = .white
        }
        if let nextScreenButton = self.view.viewWithTag(21) as? UIButton {
            nextScreenButton.setTitleColor(.white, for: .normal)
            nextScreenButton.setImage(nil, for: .normal)
        }
        if let windView = self.view.viewWithTag(22) {
            windView.backgroundColor = .white
        }
        if let feelsLikeView = self.view.viewWithTag(23) {
            feelsLikeView.backgroundColor = .white
        }
        
    }
    
}
extension UIColor {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
