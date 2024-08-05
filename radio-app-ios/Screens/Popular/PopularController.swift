//
//  PopularController.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 01.08.2024.
//

import UIKit

final class PopularController: UIViewController {
    
    private let popularView = PopularView()
    
    private var items = [
        ("POP", "Radio Record", 315, true, UIImage(named: "waveRed")),
        ("16bit", "Radio Gameplay", 240, false, UIImage(named: "waveBlue")),
        ("Punk", "Russian Punk rock", 200, false, UIImage(named: "wavePurple")),
        ("Dj remix", "IREMIX!", 54, false, UIImage(named: "waveGreen")),
        ("Adult", "RUSSIAN WAVE", 315, false, UIImage(named: "waveYellow")),
        ("Etnic", "beufm.kz", 74, false, UIImage(named: "waveLightRed"))
    ]
    
    // MARK: - Life Cycle
    override func loadView() {
        view = popularView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularView.setDelegates(self, dataSource: self)
    }
}

extension PopularController: PopularViewDelegate {
    func tappedButton() {
        print("Button is tapped")
    }
    
    func cellSelected(at indexPath: IndexPath) {
        for i in 0..<items.count {
            items[i].3 = (i == indexPath.row)
        }
        popularView.getCollectionView.reloadData()
        print("Selected cell at \(indexPath)")
    }
}

extension PopularController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCell", for: indexPath) as? PopularCell else {
            return UICollectionViewCell()
        }
        
        let item = items[indexPath.row]
        cell.configure(with: item.0, subtitle: item.1, votes: item.2, isActive: item.3, waveImage: item.4!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelected(at: indexPath)
    }
}
