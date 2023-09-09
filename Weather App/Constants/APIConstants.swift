//
//  APIConstants.swift
//  Weather App
//
//  Created by Keerthika Chokkalingam on 09/09/23.
//

import Foundation

class APIConstants {
    
    private static let accessKey: String = "4cd569ffb3ecc3bffe9c0587ff02109f"
    public static var lattitude: String = ""
    public static var longtitude: String = ""
    public static let sourceUrl: String = "https://api.openweathermap.org/data/2.5/onecall?lat=" + lattitude + "&lon=" + longtitude + "&appid=" + accessKey
    
}
