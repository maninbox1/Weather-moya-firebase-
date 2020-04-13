//
//  WeatherForecast.swift
//  Weather
//
//  Created by Mikhail Ladutska on 4/4/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

//MARK: - weather request

import Foundation
import Moya

enum WeatherForecast {
    static let darkSkyApi = "17cc2d15fb6c41dbe71882a67a89246f"
    
    case forecast(String, Double, Double)
}

extension WeatherForecast: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.darksky.net")!
    }
    
    var path: String {
        switch self {
        case let .forecast(apiKey, lat, long):
            return "/forecast/\(apiKey)/\(lat),\(long)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .forecast:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .forecast:
            return .requestParameters(parameters: ["units" : "auto"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
