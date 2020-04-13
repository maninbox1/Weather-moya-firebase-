//
//  WeatherScreenViewController.swift
//  Weather
//
//  Created by Mikhail Ladutska on 4/1/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import UIKit

class WeatherScreenViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Network.shared.weatherIsFetched {
            self.temperatureLabel.text = "\(Network.shared.currentTemp!) degrees in \(Network.shared.userCity!)"
        } else {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let weatherViewController = mainStoryBoard.instantiateViewController(identifier: "LoadingScreenViewController") as! LoadingScreenViewController
            navigationController?.pushViewController(weatherViewController, animated: true)
        }
    }

}
