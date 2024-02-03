import PomoschAPI

typealias Wards = [WardsQuery.Data.Wards.Node.PublicInformation]
typealias Ward = WardsQuery.Data.Wards.Node.PublicInformation

protocol MainInteractorProtocol: AnyObject {
    func fetchWards()
    func alphabeticallySortWards(for wards: WardsQuery.Data) -> Wards
}

class MainInteractor: MainInteractorProtocol {
    private var sortedWards: Wards = []
    weak var presenter: MainPresenterProtocol?
}

extension MainInteractor {
    
    func alphabeticallySortWards(for wards: WardsQuery.Data) -> Wards {
        guard let wards = wards.wards?.nodes else { return [] }
        let temp = wards.map { $0.publicInformation }.sorted { $0.name.firstName < $1.name.firstName }
        return temp
    }
    
    func fetchWards() {
        NetworkService.shared.fetchWards { result in
            switch result {
            case .success(let value):
                self.sortedWards = self.alphabeticallySortWards(for: value)
                self.presenter?.wardsDidLoaded(wards: self.sortedWards)
            case .failure(let error):
                print("DEBUG: \(error.localizedDescription)")
                self.presenter?.dataFetchingErrorAlert()
            }
        }
    }
}
