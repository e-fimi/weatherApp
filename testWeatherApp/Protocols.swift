//
//  Protocols.swift
//  testWeatherApp
//
//  Created by Георгий on 20.10.2021.
//

import UIKit


protocol ViewInput: AnyObject {
    func reloadData()
    func presentAlert()
}

protocol ViewOutput: AnyObject {
    func loadCity(with name: String)
    func updateCities(from models: [CityEntity])
    func checkForCoincidence(models: [CityEntity], textInput: String) -> Bool
    func didSelectItem(model: CityEntity)
}

protocol RouterInput {
    func showCity(cityEntity: CityEntity) 
}

protocol InteractorInput: AnyObject {
    func loadCity(with name: String)
}

protocol InteractorOutput: AnyObject {
    func didLoad(city: CityResponse)
    func presentNoCityAlert()
}
