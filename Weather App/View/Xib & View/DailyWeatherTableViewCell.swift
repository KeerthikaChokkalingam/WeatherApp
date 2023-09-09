//
//  DailyWeatherTableViewCell.swift
//  Weather App
//
//  Created by Keerthika Chokkalingam on 09/09/23.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpUI(dailyWeather: DailyWeatherStrcut) {
        weatherImageView.image = Utils().imageForCurrentWeather(weather: dailyWeather.weather?[0].main ?? "")
        let date = Utils().epochToLocalTime(epochTime: dailyWeather.dt ?? 0, dateRequired: false)
        if let split = date.split(separator: ",") as? [Substring], split.count >= 2 {
            datelabel.attributedText = Utils().setAttributtedText(boldText: String(split[0] + ", "), normalText: String(split[1]), boldTextSize: 16, normalTextSize: 15, firstColor: .white, secondColor: .systemGray5)
        }
        let lowTemp = String(format: "%.0f", ((dailyWeather.temp?.min ?? 0) - 273.15))
        let highTemp = String(format: "%.0f", ((dailyWeather.temp?.max ?? 0) - 273.15))
        temperatureLabel.attributedText = Utils().setAttributtedText(boldText: highTemp + " / ", normalText: lowTemp + "°", boldTextSize: 17, normalTextSize: 15, firstColor: .white, secondColor: .systemGray5)
    }
    
}

