//
//  DetailViewController.swift
//  Super easy dev
//
//  Created by Andrey on 22.01.2024
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func showWardInfo(ward: Ward)
}

class DetailViewController: UIViewController {
    
    // MARK: - Public
    
    var presenter: DetailPresenterProtocol?
    
    // MARK: - Private
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var backGroundImage: CachedImageView = {
        let backGroundImage = CachedImageView()
        return backGroundImage
    }()
    
    private lazy var blureView: UIVisualEffectView = {
        let blureEffect = UIBlurEffect(style: .light)
        let blureView = UIVisualEffectView(effect: blureEffect)
        return blureView
    }()
    
    private lazy var posterImage: CachedImageView = {
        let posterImage = CachedImageView()
        posterImage.contentMode = .scaleAspectFill
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.layer.cornerRadius = 20
        posterImage.clipsToBounds = true
        return posterImage
    }()
    
    private lazy var backgroundPosterView: UIView = {
        let backgroundPosterView = UIView()
        backgroundPosterView.translatesAutoresizingMaskIntoConstraints = false
        backgroundPosterView.backgroundColor = .clear
        return backgroundPosterView
    }()
    
    private lazy var wardName: UILabel = {
        let wardName = UILabel()
        wardName.translatesAutoresizingMaskIntoConstraints = false
        wardName.numberOfLines = 0
        wardName.textAlignment = .center
        wardName.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        wardName.textColor = .black
        return wardName
    }()
    
    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.text = "Город:"
        cityLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        cityLabel.textColor = .black
        return cityLabel
    }()
    
    private lazy var cityTextLabel: UILabel = {
        let cityTextLabel = UILabel()
        cityTextLabel.translatesAutoresizingMaskIntoConstraints = false
        cityTextLabel.textAlignment = .right
        cityTextLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        cityTextLabel.textColor = .black
        return cityTextLabel
    }()
    
    private lazy var birthDayLabel: UILabel = {
        let birthDayLabel = UILabel()
        birthDayLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDayLabel.text = "Дата рождения:"
        birthDayLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        birthDayLabel.textColor = .black
        return birthDayLabel
    }()
    
    private lazy var birthDayTextLabel: UILabel = {
        let birthDayTextLabel = UILabel()
        birthDayTextLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDayTextLabel.textAlignment = .right
        birthDayTextLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        birthDayTextLabel.textColor = .black
        return birthDayTextLabel
    }()
    
    private lazy var historyLabel: UILabel = {
        let historyLabel = UILabel()
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        historyLabel.text = "История:"
        historyLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        historyLabel.textColor = .black
        return historyLabel
    }()
    
    private lazy var historyTextLabel: UILabel = {
        let historyTextLabel = UILabel()
        historyTextLabel.translatesAutoresizingMaskIntoConstraints = false
        historyTextLabel.numberOfLines = 0
        historyTextLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        historyTextLabel.textAlignment = .natural
        historyTextLabel.textColor = .black
        return historyTextLabel
    }()
    
    private lazy var generalStackView: UIStackView = {
        let generalStackView = UIStackView(arrangedSubviews: [backgroundPosterView, wardName, birthDayStackView, cityStackView, historyStackView])
        generalStackView.distribution = .fill
        generalStackView.axis = .vertical
        generalStackView.spacing = 20
        generalStackView.translatesAutoresizingMaskIntoConstraints = false
        return generalStackView
    }()
    
    private lazy var cityStackView: UIStackView = {
        let cityStackView = UIStackView(arrangedSubviews: [cityLabel, cityTextLabel])
        cityStackView.axis = .horizontal
        cityStackView.distribution = .fill
        cityStackView.spacing = 10
        cityStackView.translatesAutoresizingMaskIntoConstraints = false
        return cityStackView
    }()
    
    private lazy var birthDayStackView: UIStackView = {
        let birthDayStackView = UIStackView(arrangedSubviews: [birthDayLabel, birthDayTextLabel])
        birthDayStackView.axis = .horizontal
        birthDayStackView.distribution = .fill
        birthDayStackView.spacing = 10
        birthDayStackView.translatesAutoresizingMaskIntoConstraints = false
        return birthDayStackView
    }()
    
    private lazy var historyStackView: UIStackView = {
        let historyStackView = UIStackView(arrangedSubviews: [historyLabel, historyTextLabel])
        historyStackView.axis = .vertical
        historyStackView.distribution = .fill
        historyStackView.spacing = 10
        historyStackView.translatesAutoresizingMaskIntoConstraints = false
        return historyStackView
    }()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backGroundImage.frame = view.bounds
        blureView.frame = view.bounds
        scrollView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
    
    @objc func didTapBackButton() {
        dismiss(animated: true)
    }
}

// MARK: - Private functions
private extension DetailViewController {
    
    func initialize() {
        presenter?.viewDidLoaded()
        configureUI()
    }
    
    func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavBar()
    }
    
    func configureNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func configureSubviews() {
        view.addSubview(backGroundImage)
        view.addSubview(blureView)
        view.addSubview(scrollView)
        backgroundPosterView.addSubview(posterImage)
        scrollView.addSubview(generalStackView)
    }
    
    func configureConstraints() {
        
        generalStackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        generalStackView.isLayoutMarginsRelativeArrangement = true
        
        NSLayoutConstraint.activate([
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: generalStackView.topAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: generalStackView.bottomAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: generalStackView.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: generalStackView.trailingAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            posterImage.topAnchor.constraint(equalTo: backgroundPosterView.topAnchor),
            posterImage.bottomAnchor.constraint(equalTo: backgroundPosterView.bottomAnchor),
            posterImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            posterImage.heightAnchor.constraint(equalTo: posterImage.widthAnchor, multiplier: 750/500),
            posterImage.centerXAnchor.constraint(equalTo: backgroundPosterView.centerXAnchor),
        ])
    }
}

// MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func showWardInfo(ward: Ward) {
        wardName.text = ward.name.fullName
        birthDayTextLabel.text = ward.dateOfBirth
        cityTextLabel.text = ward.city
        historyTextLabel.text = ward.story
        posterImage.loadImage(urlString: ward.photo.url)
        backGroundImage.loadImage(urlString: ward.photo.url)
    }
}
