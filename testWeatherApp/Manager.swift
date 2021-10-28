//
//  Manager.swift
//  testWeatherApp
//
//  Created by Георгий on 21.10.2021.
//

import Foundation

enum NetworkError: Error {
    case unexpected
}

final class Manager {
    static let appId = "d570b59a8cbdb5315f6de13660e471fb"
    
    func loadCity(with cityName: String, completion: @escaping (Result<CityResponse, Error>) -> Void) {
        guard let url = URL(string:
        "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&APIKEY=\(Manager.appId)"
        ) else {
            completion(.failure(NetworkError.unexpected))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.unexpected))
                return
            }
            
            let decoder = JSONDecoder()
            
            guard let result = try? decoder.decode(CityResponse.self, from: data) else {
                completion(.failure(NetworkError.unexpected))
                return
            }
            
            completion(.success(result))
        }
        task.resume()
    }
}
