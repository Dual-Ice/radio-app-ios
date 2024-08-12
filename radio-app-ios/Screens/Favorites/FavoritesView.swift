//
//  FavoritesView.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 30.07.2024.
//

import UIKit

final class FavoritesView: UIView {
    
    private let headerView = HeaderView()
    // MARK: - UICollection
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 290, height: 120)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.alwaysBounceVertical = true

        cv.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.identifier)

        return cv
    }()
    
    private let emptyStateLabel =  UILabel.makeCustomLabel(key: "FavoritesEmpty", fontSize: 16, textColor: .gray, numberOfLines: 0, textAligment: .center)

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegates(_ value: FavoritesController) {
        collectionView.delegate = value
        collectionView.dataSource = value
        headerView.setDelegate(value: value)
    }
    
    func configureHeader(with username: String, profileImage: UIImage) {
        headerView.configure(
            with: username,
            profileImage: profileImage,
            title: NSLocalizedString("FavoritesTitle", comment: "")
        )
    }
    
    func updateUI(forEmptyState isEmpty: Bool) {
        collectionView.isHidden = isEmpty
        emptyStateLabel.isHidden = !isEmpty
        // если isEmpty то плеер не показываем
    }

    // MARK: - Setting Views
    private func setupViews(){
        backgroundColor = Color.backgroundBlue
        
        addSubview(headerView)
        addSubview(collectionView)
        addSubview(emptyStateLabel)
        setupConstraints()
    }

    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
                
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 70),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -230),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emptyStateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
                    
        ])
    }
}
