//
//  HomeScreenViewModel.swift
//  Weather App
//
//  Created by Keerthika Chokkalingam on 08/09/23.
//

import Foundation
import UIKit

class HomeScreenViewModel {
    
    var aPIResponseModel = WeatherApp()
    
    func fetchWeatherInfo(requestUrl: String, completion: @escaping () -> ()) {
        
        let task = URLSession.shared.dataTask(with: URL(string: requestUrl)!) { data, response, error in
            if let error = error {
                completion()
            }
            guard let response = response as? HTTPURLResponse else {return}
            if response.statusCode == 200 {
                if let data = data {
                    do {
                        let responseData = try JSONDecoder().decode(WeatherApp.self, from: data)
                        self.aPIResponseModel = responseData
                        completion()
                    } catch {
                        print("Decode error: \(error)")
                        completion()
                    }
                } else {
                    completion()
                }
            } else {
                completion()
            }
        }.resume()
        
    }
    
}
