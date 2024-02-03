import UIKit

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func wardsDidLoaded(wards: Wards)
    func numberOfRows() -> Int
    func ward(at index: Int) -> Ward
    func willDisplayCell(at index: Int)
    func didSelectRow(at index: Int)
    func search(with query: String)
    func searchIsEnding()
    func dataFetchingErrorAlert()
}

class MainPresenter {
    
    private var wards: Wards = []
    private var paginationWards: Wards = []
    private var searchingWards: Wards = []
    private var pageCounter = 1
    private var isSearching = false
    
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol
    var interactor: MainInteractorProtocol
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - Extension

extension MainPresenter: MainPresenterProtocol {
    
    func dataFetchingErrorAlert() {
        view?.showAlert()
    }
    
    func searchIsEnding() {
        isSearching = false
        searchingWards = []
        view?.reloadData()
    }
    
    func search(with query: String) {
        if query != "" || query != " " {
            isSearching = true
            searchingWards = query.isEmpty ? wards : wards.filter ({ $0.name.firstName.prefix(query.count) == query })
            view?.reloadData()
        } else {
            searchIsEnding()
        }
    }
    
    func didSelectRow(at index: Int) {
        if isSearching {
            router.openDetailController(ward: searchingWards[index])
        } else {
            router.openDetailController(ward: paginationWards[index])
        }
    }
    
    func ward(at index: Int) -> Ward {
        if isSearching {
            return searchingWards[index]
        } else {
            return paginationWards[index]
        }
    }
    
    func willDisplayCell(at index: Int) {
        if index == paginationWards.count - 1, !isSearching {
            self.view?.showPaginationLoadingIndicator()
            self.pageCounter += 1
            self.paginationWards = self.loadDataForPagination(page: self.pageCounter)
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: 3.0)
                DispatchQueue.main.async {
                    self.view?.reloadData()
                    self.view?.hidePaginationLoadingIndicator()
                }
            }
        }
    }
    
    func numberOfRows() -> Int {
        if isSearching {
            return searchingWards.count
        } else {
            return paginationWards.count
        }
    }
    
    func viewDidLoaded() {
        view?.showLoadingIndicator()
        interactor.fetchWards()
    }
    
    func wardsDidLoaded(wards: Wards) {
        self.wards = wards
        paginationWards = loadDataForPagination(page: 1)
        view?.hideLoadingIndicator()
        view?.reloadData()
    }
}

// MARK: - Private extension

private extension MainPresenter {
    func loadDataForPagination(page: Int) -> Wards {
        let countOfWards = page * 10
        let startIndex = countOfWards - 10
        let endIndex = countOfWards - 1
        paginationWards.append(contentsOf: Array(wards[startIndex...endIndex]))
        return paginationWards
    }
}
