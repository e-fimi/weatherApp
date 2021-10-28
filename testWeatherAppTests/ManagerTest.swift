//
//  ManagerTest.swift
//  testWeatherAppTests
//
//  Created by Георгий on 28.10.2021.
//

import XCTest
@testable import testWeatherApp

class ManagerTest: XCTestCase {
    
    func testCanParseWeather() throws {
        let cityName : String = "Moscow"
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&APIKEY=d570b59a8cbdb5315f6de13660e471fb")!
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
        
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            
            guard let result = try? decoder.decode(CityResponse.self, from: data) else {
                return
            }
            XCTAssertEqual("Moscow", result.name)
            XCTAssertEqual(524901, result.id)
        }
        task.resume()
    }
    
}

