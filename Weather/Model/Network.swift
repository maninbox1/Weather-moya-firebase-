//
//  Network.swift
//  Weather
//
//  Created by Mikhail Ladutska on 4/10/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import Foundation
import CoreLocation
import Moya

class Network: NSObject {
    
    //MARK: - setup network manager
    
    static let shared = Network()
    var locationManager = CLLocationManager()
    var userCity: String!
    var currentTemp: Int!
    var weatherIsFetched = false
    let provider = MoyaProvider<WeatherForecast>()
    let decoder = JSONDecoder()
    
    func fetchWeather() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.provider.request(.forecast(WeatherForecast.darkSkyApi, (self.locationManager.location?.coordinate.latitude)!, (self.locationManager.location?.coordinate.longitude)!)) { (result) in
                
                switch result {
                case .success(let response):
                    do {
                        let weather = try self.decoder.decode(Model.self, from: response.data)
                        self.currentTemp = Int(weather.currently.temperature)
                        self.weatherIsFetched = true
                        NotificationCenter.default.post(name: Notification.Name("weatherIsFetched"), object: nil)
                    } catch let error {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func fetchCity(location: CLLocation) {
        
        //perform reverse geocode (convert coordinates into location name)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemark, error) in
            if error == nil {
                let userLocation = placemark?[0]
                self.userCity = userLocation?.administrativeArea
                self.fetchWeather()
                print(self.userCity!)
                
            }
        }
    }
    
}
