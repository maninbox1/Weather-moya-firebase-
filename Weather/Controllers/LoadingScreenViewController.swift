//
//  LoadingScreenViewController.swift
//  Weather
//
//  Created by Mikhail Ladutska on 4/1/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import UIKit

class LoadingScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.openWeatherScreen(notification:)),
                                               name: Notification.Name("weatherIsFetched"),
                                               object: nil)
        
        
    }
   
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Network.shared.weatherIsFetched == true {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                   let weatherViewController = mainStoryBoard.instantiateViewController(identifier: "WeatherScreenViewController") as! WeatherScreenViewController
                  navigationController?.pushViewController(weatherViewController, animated: true)
        }
    }

    
    @objc func openWeatherScreen(notification: Notification) {
    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let weatherViewController = mainStoryBoard.instantiateViewController(identifier: "WeatherScreenViewController") as! WeatherScreenViewController
       navigationController?.pushViewController(weatherViewController, animated: true)

    }
}
