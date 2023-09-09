//
//  WeatherCollectionViewCell.swift
//  Weather App
//
//  Created by Keerthika Chokkalingam on 08/09/23.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperaturelabel: UILabel!
    @IBOutlet weak var timelabel: UILabel!
    @IBOutlet weak var weatherView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        weatherView.layer.cornerRadius = 10
        weatherView.layer.borderWidth = 0.5
        weatherView.layer.borderColor = UIColor().hexStringToUIColor(hex: "464646").cgColor
    }
    
    func hourlyUIChanges(hourlyWeather: HourlyWeatherStruct?, index: Int) {
        if index == 0 {
            temperaturelabel.text = "Now"
            weatherView.backgroundColor = UIColor().hexStringToUIColor(hex: "427AFF")
            temperaturelabel.textColor = .white
            timelabel.textColor = .white
        } else {
            temperaturelabel.text = "\(String(format: "%.0f", ((hourlyWeather?.temp ?? 0) - 273.15)))°"
            weatherView.backgroundColor = UIColor.white
            temperaturelabel.textColor = .black
            timelabel.textColor = .darkGray
            
        }
        timelabel.text = Utils().epochToLocalTime(epochTime: hourlyWeather?.dt ?? 0, dateRequired: true)
        weatherImageView.image = Utils().imageForCurrentWeather(weather: hourlyWeather?.weather?[0].main ?? "")
    }
    
}
