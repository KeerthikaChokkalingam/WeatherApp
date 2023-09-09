//
//  Utils.swift
//  Weather App
//
//  Created by Keerthika Chokkalingam on 09/09/23.
//

import Foundation
import UIKit

class Utils {
    
    func setAttributtedText(boldText: String, normalText: String, boldTextSize: Int, normalTextSize: Int, firstColor: UIColor, secondColor: UIColor) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: boldText)
        
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "RobotoSlab-Bold", size: CGFloat(boldTextSize))!,
            .foregroundColor: firstColor // Set your desired color here
        ]
        
        let regularAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "RobotoSlab-Regular", size: CGFloat(boldTextSize))!,
            .foregroundColor: secondColor // Set your desired color here
        ]
        
        attributedString.append(NSAttributedString(string: normalText, attributes: regularAttributes))
        attributedString.setAttributes(boldAttributes, range: NSRange(location: 0, length: boldText.count))
        
       return attributedString
        
    }
    
    // Retrieve Local time from UNIX time
    func epochToLocalTime(epochTime: CGFloat, dateRequired: Bool) -> String {
        let currentTime = Double(epochTime)
        let date = Date(timeIntervalSince1970: currentTime)
        let dateFormatter = DateFormatter()
        if dateRequired {
            dateFormatter.dateFormat = "HH:mm"
        } else {
            dateFormatter.dateFormat = "EEEE, d MMM"
        }
        return dateFormatter.string(from: date)
    }
    
    // Images for current weather condition
    func imageForCurrentWeather(weather: String) -> UIImage {
        switch weather {
        case "Thunderstorm":
            return UIImage(named: "thunderstorm")!
        case "Drizzle":
            return UIImage(named: "drizzle")!
        case "Rain":
            return UIImage(named: "rain")!
        case "Snow":
            return UIImage(named: "snow")!
        case "Atmosphere":
            return UIImage(named: "fog")!
        case "Mist":
            return UIImage(named: "fog")!
        case "Haze":
            return UIImage(named: "fog")!
        case "Smoke":
            return UIImage(named: "fog")!
        case "Dust":
            return UIImage(named: "fog")!
        case "Fog":
            return UIImage(named: "fog")!
        case "Sand":
            return UIImage(named: "fog")!
        case "Ash":
            return UIImage(named: "fog")!
        case "Squall":
            return UIImage(named: "fog")!
        case "Tornado":
            return UIImage(named: "fog")!
        case "Clear":
            return UIImage(named: "clear")!
        case "Clouds":
            return UIImage(named: "clouds")!
        default:
            return UIImage()
        }
    }
    
    // Get local Date string
    func getLocalDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM"
        return dateFormatter.string(from: Date().localDate())
    }
    
    func getSunriceTime(interval: CGFloat) ->  String {
        let timestamp: TimeInterval = Double(interval) 
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let formattedTime = dateFormatter.string(from: date)
        return formattedTime
    }
    
    func setUpLoader(sender: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = sender.center
        activityIndicator.color = UIColor.white
        activityIndicator.tag = 444
        sender.addSubview(activityIndicator)
        return activityIndicator
    }
    func startLoading(sender: UIActivityIndicatorView, wholeView: UIView) {
        if let indicator = sender.viewWithTag(444) as? UIActivityIndicatorView {
            indicator.isHidden = false
            indicator.startAnimating()
        }
    }
    func endLoading(sender: UIActivityIndicatorView, wholeView: UIView) {
        if let indicator = sender.viewWithTag(444) as? UIActivityIndicatorView {
            indicator.isHidden = true
            indicator.hidesWhenStopped = true
            indicator.stopAnimating()
        }
    }
    
    
}
