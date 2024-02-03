import UIKit

protocol MainRouterProtocol {
    func openDetailController(ward: Ward)
}

class MainRouter: MainRouterProtocol {
    weak var viewController: MainViewController?
}

extension MainRouter {
    func openDetailController(ward: Ward) {
        let detailVC = UINavigationController(rootViewController: DetailModuleBuilder.build(wardInfo: ward))
        detailVC.modalPresentationStyle = .fullScreen
        viewController?.present(detailVC, animated: true)
    }
}
