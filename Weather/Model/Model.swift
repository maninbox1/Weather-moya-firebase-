//
//  Model.swift
//  Weather
//
//  Created by Mikhail Ladutska on 4/5/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import Foundation

//struct Model: Decodable {
//    var currentTemp: Int
//
//    init(json: [String: Any]) {
//
//    let currentlyForecast = json["currently"] as! [String: Any]
//    currentTemp = Int(currentlyForecast["temperature"] as! Double)
//
//    }
//}

struct Model: Codable {
    let currently: Currently
}

struct Currently: Codable {
    let temperature: Double
}
