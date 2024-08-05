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
    
    private let headerView = HeaderView()
    private let collectionView: UICollectionView
    private let cellIdentifier = "PopularCell"
    
    weak var delegate: PopularViewDelegate?

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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
