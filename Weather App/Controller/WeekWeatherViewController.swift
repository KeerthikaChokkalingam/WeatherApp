//
//  WeekWeatherViewController.swift
//  Weather App
//
//  Created by Keerthika Chokkalingam on 08/09/23.
//

import UIKit

class WeekWeatherViewController: UIViewController {
    
    @IBOutlet weak var dailyWeatherTableView: UITableView!
    @IBOutlet weak var locationTitleLabel: UILabel!
    
    var dailyWeather = [DailyWeatherStrcut]()
    var gettedLocation: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyWeatherTableView.register(UINib(nibName: "DailyWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyWeatherTableViewCell")
        if gettedLocation != "" {
            if let split = gettedLocation.split(separator: "+") as? [Substring], split.count >= 2 {
                locationTitleLabel.attributedText = Utils().setAttributtedText(boldText: String(split[0] + ", "), normalText: String(split[1]), boldTextSize: 17, normalTextSize: 16, firstColor: .white, secondColor: .systemGray4)
            }
        }
    }
    @IBAction func backToHomeScreen(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension WeekWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherTableViewCell", for: indexPath) as? DailyWeatherTableViewCell else {return UITableViewCell()}
        let currentData = dailyWeather[indexPath.row]
        cell.setUpUI(dailyWeather: currentData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
