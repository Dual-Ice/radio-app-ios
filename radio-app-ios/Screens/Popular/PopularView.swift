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
    
    let playerControler = PlayerControlView()
    let volumeControler = VolumeControlView()

    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 130, height: 140)
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
        [
            headerView,
            collectionView,
            playerControler,
            volumeControler
        ].forEach { addSubview($0) }
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.identifier)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 60),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: playerControler.topAnchor, constant: -10),
            
            playerControler.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerControler.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 255/335),
            playerControler.heightAnchor.constraint(equalTo: playerControler.widthAnchor, multiplier: 127/255),
            playerControler.bottomAnchor.constraint(equalTo: volumeControler.topAnchor, constant: -20),
            
            volumeControler.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            volumeControler.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 38),
            volumeControler.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -38),
            volumeControler.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func configureHeader(with username: String, profileImage: UIImage) {
        headerView.configure(
            with: username,
            profileImage: profileImage,
            title: NSLocalizedString("PopularTitle", comment: "")
        )
    }
    
    func setDelegates(_ delegate: PopularController) {
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
        headerView.setDelegate(value: delegate)
    }
    
    var getCollectionView: UICollectionView {
        return collectionView
    }
}
