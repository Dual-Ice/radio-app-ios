//
//  DetailViewController.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 10.08.2024.
//

import UIKit

final class ListView: UIView {
    
    let collectionView: UICollectionView
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 130, left: 20, bottom: 200, right: 20)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 140, height: 120)
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
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 130),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200)
        ])
    }
    
    func setDelegate(_ delegate: UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout) {
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
    }
}
