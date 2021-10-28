//
//  Presenter.swift
//  testWeatherApp
//
//  Created by Георгий on 20.10.2021.
//

import Foundation

final class Presenter {
    
    var interactor: InteractorInput
    weak var view: ViewInput?
    let router: RouterInput
        
    init(interactor: InteractorInput, router: RouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    
    func viewModel(from city: CityResponse) -> CityViewModel {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        var description: String = ""
        var secondDescription: String = ""
        city.weather.forEach { cityWeatherInfo in
            description = cityWeatherInfo.main
            secondDescription = cityWeatherInfo.description
        }
        return CityViewModel(title: city.name,
                             temperature: String(Int(city.main.temp)),
                             dateUpdate: dateFormatter.string(from: Date()),
                             description: description,
                             secondDescription: secondDescription)
    }
    
    func viewModeltoCoreData(cityViewModel: CityViewModel) {
        ViewController.coreDataManager.createObject(for: CityEntity.self) { city in
            city.title = cityViewModel.title
            city.dateUpdated = cityViewModel.dateUpdate
            city.temperature = cityViewModel.temperature
            city.firstDescription = cityViewModel.description
            city.secondDescription = cityViewModel.secondDescription
        }
    }
}

extension Presenter: ViewOutput {
    
    func loadCity(with name: String){
        interactor.loadCity(with: name)
    }
    
    func updateCities(from models: [CityEntity]) {
        models.forEach { city in
            let cityName = city.title
            ViewController.coreDataManager.deleteObject(city: city)
            interactor.loadCity(with: cityName ?? "Moscow")
        }
    }
    
    func checkForCoincidence(models: [CityEntity], textInput: String) -> Bool {
        var flag: Bool = true
        
        models.forEach { city in
            if city.title == textInput {
                flag = false
            }
        }
        return flag
    }
    
    func didSelectItem(model: CityEntity) {
        router.showCity(cityEntity: model)
    }
}

extension Presenter: InteractorOutput {
    func didLoad(city: CityResponse) {
        self.viewModeltoCoreData(cityViewModel: viewModel(from: city))
        self.view?.reloadData()
    }
    
    func presentNoCityAlert() {
        self.view?.presentAlert()
    }
    
}
