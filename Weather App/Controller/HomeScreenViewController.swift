//
//  HomeScreenViewController.swift
//  Weather App
//
//  Created by Keerthika Chokkalingam on 08/09/23.
//

import UIKit
import CoreLocation

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var pressurelabel: UILabel!
    @IBOutlet weak var indexUvLabel: UILabel!
    @IBOutlet weak var feeldLikeLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var temperaturelabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var weatherChatCollection: UICollectionView!
    @IBOutlet weak var bottomLeftWholeView: UIView!
    @IBOutlet weak var bottomRightWholeView: UIView!
    @IBOutlet weak var bottomRightView: UIView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var bottomWholeView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var todayWeatherView: UIView!
    
    var locationManager = CLLocationManager()
    var viewModel: HomeScreenViewModel?
    var gettedResponse = WeatherApp()
    var hourlyWeather = [HourlyWeatherStruct]()
    var gettedLocation: String = ""
    var indicator = UIActivityIndicatorView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocationAuthorization()
        startLocationUpdates()
        collectionAndUISetUp()
    }
    
    
    @IBAction func goToWeekWeather(_ sender: UIButton) {
        guard let weeklyWeatherScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeekWeatherViewController") as? WeekWeatherViewController else {return}
        weeklyWeatherScreen.dailyWeather = gettedResponse.daily ?? [DailyWeatherStrcut]()
        weeklyWeatherScreen.gettedLocation = gettedLocation
        self.navigationController?.pushViewController(weeklyWeatherScreen, animated: true)
    }
    
}

extension HomeScreenViewController {
    
    func collectionAndUISetUp() {
        bottomRightView.layer.cornerRadius = 20
        bottomLeftView.layer.cornerRadius = 20
        bottomWholeView.layer.cornerRadius = 20
        topView.layer.cornerRadius = 20
        todayWeatherView.layer.cornerRadius = 20
        bottomLeftWholeView.layer.cornerRadius = 20
        bottomRightWholeView.layer.cornerRadius = 20
        weatherChatCollection.delegate = self
        weatherChatCollection.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        weatherChatCollection.collectionViewLayout = layout
        weatherChatCollection.register(UINib(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCollectionViewCell")
        indicator = Utils().setUpLoader(sender: view)
    }
    
    func SetUpUI() {
        currentImage.image = Utils().imageForCurrentWeather(weather: gettedResponse.current?.weather?[0].main ?? "")
        descriptionLabel.text = (gettedResponse.current?.weather?[0].description as? String)?.capitalized
        dateLabel.text = Utils().getLocalDate()
        temperaturelabel.text = "\(String(format: "%.0f", ((gettedResponse.current?.temp ?? 0) - 273.15)))°"
        windLabel.text = "\(String(describing: gettedResponse.current?.wind_speed ?? 0)) km/j"
        feeldLikeLabel.text = "\(String(format: "%.1f", ((gettedResponse.current?.feels_like ?? 0) - 273.15)))°"
        indexUvLabel.text = Utils().getSunriceTime(interval: gettedResponse.current?.sunrise ?? 0)
        pressurelabel.text = "\(String(describing: gettedResponse.current?.pressure ?? 0)) mbar"
    }
    
    func getWeatherApiCall() {
        if NetworkConnectionHandler().checkReachable() {
            Utils().startLoading(sender: indicator, wholeView: view)
            viewModel = HomeScreenViewModel()
            viewModel?.fetchWeatherInfo(requestUrl: APIConstants.sourceUrl, completion: { [self]
                self.gettedResponse = self.viewModel?.aPIResponseModel ?? WeatherApp()
                self.hourlyWeather = self.gettedResponse.hourly ?? [HourlyWeatherStruct]()
                print(self.gettedResponse)
                DispatchQueue.main.async {
                    Utils().endLoading(sender: self.indicator ?? UIActivityIndicatorView() , wholeView: self.view ?? UIView())
                    self.weatherChatCollection.reloadData()
                    self.SetUpUI()
                }
            })
            if gettedResponse == nil {
                errorViewSetUp()
            }
        } else {
            errorViewSetUp()
            let controller = UIAlertController(title: "No Internet Detected", message: "This app requires an Internet connection", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                controller.dismiss(animated: true)
                }
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
        }

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
                    currentCityLabel.attributedText = Utils().setAttributtedText(boldText: city + ", ", normalText: country, boldTextSize: 19, normalTextSize: 17, firstColor: .black, secondColor: .systemGray)
                }
                else {
                }
            }
            getWeatherApiCall()
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Check if the locations array is not empty
        var currentLocation: CLLocation!
        guard let location = locations.last else {
            return
        }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        APIConstants.lattitude = "\(latitude)"
        APIConstants.longtitude = "\(longitude)"
        locationManager.stopUpdatingLocation()
        currentLocation = locationManager.location
        guard let currentLocation else { return }
        CLGeocoder().reverseGeocodeLocation(currentLocation) { [self] (placemarks, error) -> Void in
            if error != nil {
                return
            }else if let country = placemarks?.first?.country,
                     let city = placemarks?.first?.locality {
                gettedLocation = city + "+" + country
                currentCityLabel.attributedText = Utils().setAttributtedText(boldText: city + ", ", normalText: country, boldTextSize: 17, normalTextSize: 16, firstColor: .black, secondColor: .systemGray)
            }
            else {
            }
        }
        getWeatherApiCall()
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rowCount: Int = 0
        if hourlyWeather.count > 0 {
            let evenNumberedStructs = self.hourlyWeather.enumerated().filter { $0.offset % 2 == 0 }.map { $0.element }
            return evenNumberedStructs.count
        }
        return rowCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as? WeatherCollectionViewCell else {return UICollectionViewCell()}
        if hourlyWeather.count > 0 {
            let evenNumberedStructs = self.hourlyWeather.enumerated().filter { $0.offset % 2 == 0 }.map { $0.element }
            let currentData = evenNumberedStructs[indexPath.row]
            cell.hourlyUIChanges(hourlyWeather: currentData, index: indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 140)
    }
    
}
