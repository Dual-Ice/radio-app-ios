//
//  AllView.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 07.08.2024.
//

import UIKit

protocol AllViewDelegate: AnyObject {
    func tappedButton()
}

final class AllView: UIView {
    weak var delegate: AllViewDelegate?
    
    var favRecipes = ["title1", "title2"]
    
    // MARK: - UI
    
    private let bgImage = UIImageView.makeSimpleImage(imageName: "signInBackground")
    
    lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.estimatedItemSize.width = 291
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 16
    
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.translatesAutoresizingMaskIntoConstraints = false
            //cv.backgroundColor = .clear
            cv.backgroundColor = .blue
            cv.showsVerticalScrollIndicator = false
            cv.alwaysBounceVertical = true
    
            cv.register(StationCell.self, forCellWithReuseIdentifier: StationCell.identifier)
    
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
    
        self.addSubview(bgImage)
        
        [collectionView
        ].forEach{ bgImage.addSubview($0) }
        
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


