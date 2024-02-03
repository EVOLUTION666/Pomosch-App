//
//  DetailPresenter.swift
//  Super easy dev
//
//  Created by Andrey on 22.01.2024
//

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

class DetailPresenter {
    weak var view: DetailViewProtocol?
    var router: DetailRouterProtocol
    var interactor: DetailInteractorProtocol

    init(interactor: DetailInteractorProtocol, router: DetailRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoaded() {
        let wardInfo = interactor.returnWard()
        view?.showWardInfo(ward: wardInfo)
    }
}
