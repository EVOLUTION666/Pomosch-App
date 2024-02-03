import UIKit

protocol MainViewProtocol: AnyObject {
    func showAlert()
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showPaginationLoadingIndicator()
    func hidePaginationLoadingIndicator()
    func reloadData()
}

class MainViewController: UIViewController {
    
    // MARK: - Public
    
    var presenter: MainPresenterProtocol?
    
    // MARK: - Private
    
    private lazy var alertController: UIAlertController = {
        let alertController = UIAlertController(title: "Ошибка",
                                                message: "Не удалось загрузить данные. Проверьте соединение с интернетом.",
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Закрыть", style: .default)
        alertController.addAction(alertAction)
        return alertController
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        return activityIndicator
    }()
    
    private lazy var paginationActivityIndicator: UIActivityIndicatorView = {
        let paginationActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        paginationActivityIndicator.center = view.center
        paginationActivityIndicator.hidesWhenStopped = true
        paginationActivityIndicator.color = .black
        return paginationActivityIndicator
    }()
    
    private lazy var searchController: UISearchController = {
        
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Поиск...", attributes: [NSAttributedString.Key.foregroundColor:UIColor.black])
        searchController.searchBar.searchTextField.leftView?.tintColor = .black
        searchController.searchBar.searchTextField.rightView?.tintColor = .black
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        return searchController
        
        //        let searchController = UISearchController()
        //        searchController.searchBar.sizeToFit()
        //        searchController.searchBar.searchBarStyle = .default
        ////        searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Поиск...", attributes: [NSAttributedString.Key.foregroundColor:UIColor.black])
        ////        searchController.searchBar.searchTextField.leftView?.tintColor = .black
        //        definesPresentationContext = false
        //        searchController.searchBar.delegate = self
        //        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(WardTableViewCell.self, forCellReuseIdentifier: WardTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

// MARK: - Private functions

private extension MainViewController {
    func initialize() {
        presenter?.viewDidLoaded()
        configureUI()
    }
    
    func configureUI() {
        title = "Подопечные"
        view.backgroundColor = .white
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.isTranslucent = false
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.black
        }
        view.addSubview(tableView)
        tableView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
    }
}

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    
    func showAlert() {
        present(alertController, animated: true)
    }
    
    func showPaginationLoadingIndicator() {
        tableView.tableFooterView = paginationActivityIndicator
        paginationActivityIndicator.startAnimating()
    }
    
    func hidePaginationLoadingIndicator() {
        tableView.tableFooterView = nil
        paginationActivityIndicator.stopAnimating()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.search(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchIsEnding()
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.willDisplayCell(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WardTableViewCell.identifier, for: indexPath) as! WardTableViewCell
        if let ward = presenter?.ward(at: indexPath.row) {
            cell.configure(ward: ward)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath.row)
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
