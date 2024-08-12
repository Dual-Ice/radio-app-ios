//
//  AllView.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 11.08.2024.
//

import UIKit


final class AllView: UIView {
        
    // MARK: - UI
    
    private let headerView = HeaderView()
    private let playerControler = PlayerControlView()
    private let volumeControler = VolumeControlView()
    
    lazy var searchTextField: UISearchTextField = {
        var element = UISearchTextField()
        
        element.backgroundColor = Color.customGray
        element.textColor = .white
        element.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("SearchRadioStation", comment: "") , attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        if let leftView = element.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.white
        }
        element.translatesAutoresizingMaskIntoConstraints = false
        
        return element
    }()
    
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
        
        cv.register(AllStationCell.self, forCellWithReuseIdentifier: AllStationCell.identifier)
        
        return cv
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegates(allVD: AllController, playerVD: PlayerControlDelegate) {
        collectionView.delegate = allVD
        collectionView.dataSource = allVD
        headerView.setDelegate(value: allVD)
        playerControler.delegate = playerVD
    }
    
    // MARK: - Set Views
    
    private func setViews() {
        self.backgroundColor = Color.backgroundBlue
    
        [
            headerView,
            searchTextField,
            collectionView,
            playerControler,
            volumeControler
        ].forEach { addSubview($0) }
    }
    
    // MARK: - Setup Constraints
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            searchTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 60),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
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
            title: NSLocalizedString("AllStations", comment: "")
        )
    }
    
    var getCollectionView: UICollectionView {
        return collectionView
    }
}
