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
    let playerControler = PlayerControlView()
    let volumeControler = VolumeControlView()
    
    
    private let emptyStateLabel =  UILabel.makeCustomLabel(key: "SearchEmpty", fontSize: 16, textColor: .gray, numberOfLines: 0, textAligment: .center)
    var searchIcon = Image.searchMagnifying
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        let image = searchIcon?.withTintColor(.white, renderingMode: .alwaysOriginal)
        searchBar.setImage(image, for: .search, state: .normal)
        searchBar.searchTextField.attributedPlaceholder =  NSAttributedString(string: NSLocalizedString("SearchRadioStation", comment: "") , attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.8)])
        searchBar.backgroundColor = .clear
        searchBar.tintColor = .white
        searchBar.searchTextField.backgroundColor = Color.customGray
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.cornerRadius = 8
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.setImage(UIImage(systemName: "xmark.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .clear, state: .normal)
        searchBar.searchTextField.textColor = .white
        // Set the background image of the searchBar to a transparent image
        searchBar.backgroundImage = UIImage()
        
        return searchBar
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
        
        searchBar.delegate = allVD
    }
    
    // MARK: - Set Views
    private func setViews() {
        self.backgroundColor = Color.backgroundBlue
    
        [
            headerView,
            searchBar,
            collectionView,
            emptyStateLabel,
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
            
            searchBar.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 60),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: playerControler.topAnchor, constant: -10),

            playerControler.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerControler.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 255/335),
            playerControler.heightAnchor.constraint(equalTo: playerControler.widthAnchor, multiplier: 127/255),
            playerControler.bottomAnchor.constraint(equalTo: volumeControler.topAnchor, constant: -20),
            
            volumeControler.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            volumeControler.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 38),
            volumeControler.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -38),
            volumeControler.heightAnchor.constraint(equalToConstant: 16),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emptyStateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    func configureHeader(with username: String, profileImage: UIImage) {
        headerView.configure(
            with: username,
            profileImage: profileImage,
            title: NSLocalizedString("AllStations", comment: "")
        )
    }
    
    func switchHeader(_ value: Bool) {
        headerView.switchTitle(value)
    }
    
    var getCollectionView: UICollectionView {
        return collectionView
    }
    
    func updateUI(forEmptyState isEmpty: Bool, with isSearching: Bool) {
        collectionView.isHidden = isEmpty
        emptyStateLabel.isHidden = !isEmpty || !isSearching
        playerControler.isHidden = isEmpty
        volumeControler.isHidden = isEmpty
    }
}
