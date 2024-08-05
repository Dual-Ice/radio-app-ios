//
//  PopularView.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 01.08.2024.
//

import UIKit

protocol PopularViewDelegate: AnyObject {
    func tappedButton()
    func cellSelected(at indexPath: IndexPath)
}

final class PopularView: UIView {
    
    private let collectionView: UICollectionView
    private let cellIdentifier = "PopularCell"
    
    weak var delegate: PopularViewDelegate?
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 150, left: 50, bottom: 150, right: 50)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 139, height: 139)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
        
        setupCollectionView()
        self.backgroundColor = Color.backgroundBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setDelegates(_ delegate: PopularViewDelegate, dataSource: UICollectionViewDataSource) {
        self.delegate = delegate
        collectionView.delegate = delegate as? UICollectionViewDelegate
        collectionView.dataSource = dataSource
    }
    
    var getCollectionView: UICollectionView {
        return collectionView
    }
}
