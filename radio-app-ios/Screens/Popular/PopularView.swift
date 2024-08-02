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
    
    private var items = [
        ("POP", "Radio Record", 315, true, UIImage(named: "waveRed")),
        ("16bit", "Radio Gameplay", 240, false, UIImage(named: "waveBlue")),
        ("Punk", "Russian Punk rock", 200, false, UIImage(named: "wavePurple")),
        ("Dj remix", "IREMIX!", 54, false, UIImage(named: "waveGreen")),
        ("Adult", "RUSSIAN WAVE", 315, false, UIImage(named: "waveYellow")),
        ("Etnic", "beufm.kz", 74, false, UIImage(named: "waveLightRed"))
    ]
    
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setDelegates(_ delegate: PopularViewDelegate) {
        self.delegate = delegate
    }
}

extension PopularView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PopularCell else {
            return UICollectionViewCell()
        }
        
        let item = items[indexPath.row]
        cell.configure(with: item.0, subtitle: item.1, votes: item.2, isActive: item.3, waveImage: item.4!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<items.count {
            items[i].3 = (i == indexPath.row)
        }
        collectionView.reloadData()
        delegate?.cellSelected(at: indexPath)
    }
}
