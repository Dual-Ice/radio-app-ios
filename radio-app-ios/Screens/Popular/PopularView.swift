//
//  PopularView.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 01.08.2024.
//

import UIKit

final class PopularView: UIView {
    
    private let headerView = HeaderView()
    private let collectionView: UICollectionView
    private let cellIdentifier = "PopularCell"

    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 80, left: 60, bottom: 80, right: 40)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 139, height: 139)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        self.backgroundColor = Color.backgroundBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(headerView)
        addSubview(collectionView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 520)
        ])
    }
    
    func configureHeader(with username: String, profileImage: UIImage) {
        headerView.configure(with: username, profileImage: profileImage)
    }
    
    func setDelegates(_ delegate: UICollectionViewDelegate & UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
    }
    
    var getCollectionView: UICollectionView {
        return collectionView
    }
}
