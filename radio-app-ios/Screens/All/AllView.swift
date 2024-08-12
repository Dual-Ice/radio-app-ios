//
//  AllView.swift
//  radio-app-ios
//
<<<<<<< HEAD
=======
//  Created by  Maksim Stogniy on 11.08.2024.
//
//
//  AllView.swift
//  radio-app-ios
//
>>>>>>> 95a53d95ce8562a689cf7f9f4390e5263815a019
//  Created by Дмитрий Волков on 07.08.2024.
//

import UIKit

protocol AllViewDelegate: AnyObject {
    func tappedButton()
}

final class AllView: UIView {
    weak var delegate: AllViewDelegate?
    
    var stations = [StationModel(radioTitle: "PopOne", genre: "Pop", isPlayingNow: false, votes: "340"),
    StationModel(radioTitle: "RockingHard", genre: "Rock", isPlayingNow: false, votes: "234"),
    StationModel(radioTitle: "DeepState", genre: "House", isPlayingNow: false, votes: "678")]
    
    // MARK: - UI
    
    lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.estimatedItemSize.width = 291
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 16
    
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.backgroundColor = .clear
            cv.showsVerticalScrollIndicator = false
            cv.alwaysBounceVertical = true
    
<<<<<<< HEAD
            cv.register(StationCell.self, forCellWithReuseIdentifier: StationCell.identifier)
=======
            cv.register(AllStationCell.self, forCellWithReuseIdentifier: AllStationCell.identifier)
>>>>>>> 95a53d95ce8562a689cf7f9f4390e5263815a019
    
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
    
    func setDelegates(_ value: AllController) {
        delegate = value
    }
    
    // MARK: - Set Views
    
    private func setViews() {
        
        self.backgroundColor = Color.backgroundBlue
        self.addSubview(collectionView)
        
        setUpViews()
    }
    
    private func setUpViews(){
    }
    
    @objc private func buttonTapped(){
        delegate?.tappedButton()
    }
    
    
    // MARK: - Setup Constraints
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: self.topAnchor),
            bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bgImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bgImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -130)
            
        ])
    }
}

<<<<<<< HEAD

=======
>>>>>>> 95a53d95ce8562a689cf7f9f4390e5263815a019
