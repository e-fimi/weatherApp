//
//  ServiceModel.swift
//  testWeatherApp
//
//  Created by Георгий on 21.10.2021.
//

import Foundation

struct CitiesResponse: Decodable {
    let list : [CityResponse]
}

struct CityResponse: Decodable {
    let name: String
    let id: Int
    let weather: [CityWeatherInfo]
    let main: CityMainInfo
}

struct CityWeatherInfo: Decodable {
    let main: String
    let description: String
}

struct CityMainInfo: Decodable {
    let temp: Float
    let feelsLike: Float
    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case temp
    }
}


