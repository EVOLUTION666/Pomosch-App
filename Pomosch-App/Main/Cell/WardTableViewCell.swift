//
//  WardTableViewCell.swift
//  Pomosch-App
//
//  Created by Andrey on 22.01.2024.
//

import UIKit
import PomoschAPI

class WardTableViewCell: UITableViewCell {
    
    static let identifier = "WardTableViewCell"
    
    // MARK: - Private
    
    private lazy var wardImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var backView: UIView = {
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.clipsToBounds = true
        backView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        backView.layer.cornerRadius = 10
        backView.backgroundColor = UIColor(named: "backView")
        return backView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstName, middleName])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var firstName: UILabel = {
        let firstName = UILabel()
        firstName.translatesAutoresizingMaskIntoConstraints = false
        firstName.text = "Валентина"
        firstName.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        firstName.numberOfLines = 0
        firstName.textColor = UIColor.white
        return firstName
    }()
    
    private lazy var middleName: UILabel = {
        let middleName = UILabel()
        middleName.translatesAutoresizingMaskIntoConstraints = false
        middleName.text = "Петровна"
        middleName.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        middleName.numberOfLines = 0
        middleName.textColor = UIColor.white
        return middleName
    }()
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //        wardImageView.image = nil
    }
    
    func configure(ward: Ward) {
        wardImageView.loadImage(urlString: ward.photo.url)
        firstName.text = ward.name.firstName
        middleName.text = ward.name.middleName
    }
    
}

private extension WardTableViewCell {
    
    func initialize() {
        setupUI()
        configureConstraints()
    }
    
    func setupUI() {
        contentView.addSubview(wardImageView)
        contentView.addSubview(backView)
        backView.addSubview(stackView)
    }
    
    func configureConstraints() {
        
        //        middleName.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            wardImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            wardImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            wardImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            wardImageView.widthAnchor.constraint(equalToConstant: 120),
            
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28),
            backView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            backView.leadingAnchor.constraint(equalTo: wardImageView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28),
            
            stackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -16),
            
        ])
    }
}
