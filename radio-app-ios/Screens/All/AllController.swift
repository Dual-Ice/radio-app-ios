//
//  AllController.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 07.08.2024.
//

import UIKit

final class AllController: UIViewController {
    
    
    private let allView = AllView()
    
    public var stations = [StationModel(radioTitle: "PopOne", genre: "Pop", isPlayingNow: true, votes: "340"),
    StationModel(radioTitle: "RockingHard", genre: "Rock", isPlayingNow: false, votes: "234"),
    StationModel(radioTitle: "DeepState", genre: "House", isPlayingNow: false, votes: "678")]
    
    // MARK: - Life Cycle
    override func loadView() {
        view = allView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allView.setDelegates(self)
        allView.collectionView.delegate = self
        allView.collectionView.dataSource = self
    }
    
}





extension AllController: AllViewDelegate {
    func tappedButton() {
        print("Button is tapped")
    }
    
}

extension AllController: UICollectionViewDataSource, UICollectionViewDelegate {
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                stations.count
            }

            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StationCell.identifier, for: indexPath) as? StationCell else {
                    return UICollectionViewCell()
                }
                
                cell.genreStation.text = stations[indexPath.row].genre
                cell.nameStation.text = stations[indexPath.row].radioTitle
                cell.votes.text = "votes \(stations[indexPath.row].votes)"
                
                if !stations[indexPath.row].isPlayingNow {
                    cell.playingStatus.isHidden = true
                    cell.imageHeart.image = UIImage(named: "heartDeselected")
                    cell.contentView.backgroundColor = .clear
                }
                
                return cell
            }
}
