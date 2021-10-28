//
//  ModuleContainer.swift
//  testWeatherApp
//
//  Created by Георгий on 20.10.2021.
//

import UIKit

final class ModuleContainer {
    var viewController = UIViewController()
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    class func assemble() -> ModuleContainer {
        let interactor = Interactor()
        let router = Router()
        let presenter = Presenter(interactor: interactor, router: router)
        interactor.output = presenter 
        let viewController = ViewController(output: presenter)
        presenter.view = viewController
        router.sourceViewController = viewController
        return ModuleContainer(viewController: viewController)
    }
}
