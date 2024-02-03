//
//  DetailModuleBuilder.swift
//  Super easy dev
//
//  Created by Andrey on 22.01.2024
//

import UIKit

class DetailModuleBuilder {
    static func build(wardInfo: Ward) -> DetailViewController {
        let interactor = DetailInteractor(with: wardInfo)
        let router = DetailRouter()
        let presenter = DetailPresenter(interactor: interactor, router: router)
        let viewController = DetailViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
