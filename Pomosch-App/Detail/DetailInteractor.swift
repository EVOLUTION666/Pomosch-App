//
//  DetailInteractor.swift
//  Super easy dev
//
//  Created by Andrey on 22.01.2024
//

protocol DetailInteractorProtocol: AnyObject {
    func returnWard() -> Ward
}

class DetailInteractor: DetailInteractorProtocol {
    private var wardInfo: Ward
    weak var presenter: DetailPresenterProtocol?
    
    init(with wardInfo: Ward) {
        self.wardInfo = wardInfo
    }
}

extension DetailInteractor {
    func returnWard() -> Ward {
        return self.wardInfo
    }
}
