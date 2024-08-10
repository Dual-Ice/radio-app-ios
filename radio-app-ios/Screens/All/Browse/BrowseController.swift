//
//  RadioStationViewController.swift
//  radio-app-ios
//
//  Created by Валентина Попова on 10.08.2024.
//

import UIKit

class BrowseController: UIViewController {
    
    private let categories = ["browse_by_tags", "browse_by_language", "browse_by_country"]
    private let dataDictionary: [String: [String]] = [
        "Browse by tags": ["Rock", "Pop", "Jazz", "Classical", "Hip-hop", "Electronic", "Reggae", "Country", "Blues", "Latin"],
        "Browse by language": ["English", "Spanish", "French", "German", "Russian", "Chinese", "Portuguese", "Arabic", "Italian", "Japanese"],
        "Browse by country": ["United States", "United Kingdom", "Germany", "France", "Russia", "Spain", "Italy", "Canada", "Brazil", "Australia"]
    ]
    
    private let browseView = BrowseView()
    
    override func loadView() {
        view = browseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        browseView.setDelegate(self)
    }
}

extension BrowseController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            return UICollectionViewCell()
        }
        let categoryKey = categories[indexPath.item]
        cell.configure(with: categoryKey)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let selectedCategoryKey = categories[indexPath.item]
        
        let keyForDataDictionary: String
        switch selectedCategoryKey {
        case "browse_by_tags":
            keyForDataDictionary = "Browse by tags"
        case "browse_by_language":
            keyForDataDictionary = "Browse by language"
        case"browse_by_country":
            keyForDataDictionary = "Browse by country"
        default:
            return
        }
        
        if let items = dataDictionary[keyForDataDictionary] {
            let listlVC = ListController(items: items, title: NSLocalizedString(selectedCategoryKey, comment: ""))
            navigationController?.pushViewController(listlVC, animated: true)
        }
    }
}
