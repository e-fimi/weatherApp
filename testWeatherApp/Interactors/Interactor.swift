//
//  Interactor.swift
//  testWeatherApp
//
//  Created by Георгий on 21.10.2021.
//

import Foundation


final class Interactor {
    weak var output: InteractorOutput?
    private let manager = Manager()
    
}

extension Interactor: InteractorInput {
    func loadCity(with name: String) {
        manager.loadCity(with: name) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let city):
                    self?.output?.didLoad(city: city)
                case .failure(let error):
                    self?.output?.presentNoCityAlert()
                    print(error)
                }
            }
        }
    }
}
