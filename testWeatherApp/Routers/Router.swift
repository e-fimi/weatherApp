//
//  Router.swift
//  testWeatherApp
//
//  Created by Георгий on 20.10.2021.
//

import UIKit

final class Router {
    weak var sourceViewController: UIViewController?
}

extension Router: RouterInput {
    func showCity(cityEntity: CityEntity) {
        let viewController = DetailsViewController()
        viewController.view.backgroundColor = .white
        viewController.configureWithCityEntity(cityEntity: cityEntity)
        let navigationController = UINavigationController(rootViewController: viewController)
        sourceViewController?.present(navigationController, animated: true, completion: nil)
    }
}

