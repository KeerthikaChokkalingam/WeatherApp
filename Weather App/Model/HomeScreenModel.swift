//
//  HomeScreenModel.swift
//  Weather App
//
//  Created by Keerthika Chokkalingam on 09/09/23.
//

import Foundation

class HomeScreenModel {
    
}

struct WeatherApp: Codable {
    var lat: CGFloat?
    var lon: CGFloat?
    var timezone: String?
    var timezone_offset: CGFloat?
    var current: CurrentDay?
    var hourly: [HourlyWeatherStruct]?
    var daily: [DailyWeatherStrcut]?
}
struct CurrentDay: Codable {
    var dt: CGFloat?
    var sunrise: CGFloat?
    var sunset: CGFloat?
    var temp: CGFloat?
    var feels_like: CGFloat?
    var pressure: CGFloat?
    var humidity: CGFloat?
    var dew_point: CGFloat?
    var uvi: CGFloat?
    var clouds: CGFloat?
    var visibility: CGFloat?
    var wind_speed: CGFloat?
    var wind_deg: CGFloat?
    var weather: [WeatherStruct]?
}
struct WeatherStruct: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}
struct HourlyWeatherStruct: Codable {
    var dt: CGFloat?
    var sunrise: CGFloat?
    var sunset: CGFloat?
    var temp: CGFloat?
    var feels_like: CGFloat?
    var pressure: CGFloat?
    var humidity: CGFloat?
    var dew_point: CGFloat?
    var uvi: Float?
    var clouds: CGFloat?
    var visibility: CGFloat?
    var wind_speed: CGFloat?
    var wind_deg: CGFloat?
    var weather: [WeatherStruct]?
    var wind_gust: CGFloat?
    var pop: Float?
}
struct DailyWeatherStrcut: Codable {
    var dt: CGFloat?
    var sunrise: CGFloat?
    var sunset: CGFloat?
    var temp: TempWeatherStrcut?
    var feels_like: TempWeatherStrcut?
    var pressure: CGFloat?
    var humidity: CGFloat?
    var dew_point: CGFloat?
    var wind_speed: CGFloat?
    var wind_deg: CGFloat?
    var wind_gust: CGFloat?
    var weather: [WeatherStruct]?
    var cloud: CGFloat?
    var pop: CGFloat?
    var uvi: CGFloat?
}
struct TempWeatherStrcut: Codable {
    var day: CGFloat?
    var min: CGFloat?
    var max: CGFloat?
    var night: CGFloat?
    var eve: CGFloat?
    var morn: CGFloat?
}
