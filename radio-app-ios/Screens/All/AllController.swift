//
//  AllController.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 07.08.2024.
//

import UIKit

final class AllController: UIViewController {
    
    
    private let allView = AllView()
    
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
                10 // test
            }

            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StationCell.identifier, for: indexPath) as? StationCell else {
                return UICollectionViewCell()
                }
                //        cell.configure(model: Station)
                return cell
            }
}


//import UIKit
//
//final class FavoritesController: UIViewController {
//
//    private let favoritesView = FavoritesView()
//
//
//    // MARK: - Life Cycle
//    override func loadView() {
//        view = favoritesView
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        favoritesView.collectionView.delegate = self
//        favoritesView.collectionView.dataSource = self
//            }
//        }
//
//
//        extension FavoritesController: FavoriteCellDelegate {
//            func tappedButton() {
//                print("Button is tapped")
//            }
//        }
//
//        extension FavoritesController: UICollectionViewDataSource, UICollectionViewDelegate {
//            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//                30 // test
//            }
//
//                func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else {
//                        return UICollectionViewCell()
//                                }
//                                //        cell.configure(model: Station)
//                    return cell
//                        }
//                    }




