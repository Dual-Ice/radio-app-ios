//
//  VerticalTabBarPresenter.swift
//  radio-app-ios
//
//  Created by nik on 30.07.24.
//

import UIKit

protocol VerticalTabBarPresenterProtocol: AnyObject {
    func loadViewController(_ navigationController: UINavigationController)
    func didChooseView(_ view: String)
}

final class VerticalTabBarPresenter: VerticalTabBarPresenterProtocol {
    private unowned let tabBarController: VerticalTabBarControllerProtocol
    
    //MARK: - Modules. Enter here the name and class of the controllers to display
    private var viewControllers: [String: UIViewController] = [:]
        
    init(tabBarController: VerticalTabBarControllerProtocol) {
        self.tabBarController = tabBarController
    }
    
    func loadViewController(_ navigationController: UINavigationController) {
        #warning("заполнить нужными контроллерами")
        viewControllers["Popular"] = PopularBuilder.buildPopularController(navigationController)
        viewControllers["Favorites"] = PopularBuilder.buildPopularController(navigationController)
        viewControllers["AllStations"] = testVC()
        
        viewControllers.keys.sorted(by: >).forEach { viewName  in
            let title = NSLocalizedString(viewName, comment: "Localizable")
            tabBarController.addTabBarButtons(title, identifier: viewName)
        }
    }
    
    func didChooseView(_ view: String) {
        tabBarController.showView(viewControllers[view] ?? UIViewController())
    }
}


#warning("TO DO: Заглушки. Удалить после заполнения viewControllers[:]")
class testVC: UIViewController {
    let mStations: [String] = [
        "https://0n-jazz.radionetz.de/0n-jazz.mp3",
        "https://stream.rockantenne.de/alternative/stream/mp3",
        "https://stream.zeno.fm/fu24r3f24c9uv",
        "https://stream-176.zeno.fm/a3th9bd1fs8uv?zs=e8ersugnTZy8yQsXXp2s2A",
        "https://drive.uber.radio/uber/crberlinphilharmonic/icecast.audio"
    ]
    
    private let playerControler = PlayerControlView()
    private let volumeControler = VolumeControlView()
            
    var stations: [Station] = []
    
    override func loadView() {
        for i in 0..<mStations.count {
            let station = Station(
                name: mStations[i],
                stationuuid: "\(i)",
                url: mStations[i],
                tags: "tags \(i)",
                favicon: "favicon \(i)",
                votes: i,
                country: "country \(i)",
                language: "language \(i)",
                geo_lat: Double(i)
            )
            stations.append(station)
        }
        
        AudioPleer.shared.loadStationList(stations)
        
        let testView = UIView()
        testView.backgroundColor = Color.backgroundBlue
        let label = UILabel()
        label.text = "Test VC"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton()
        button.setTitle("Button: Next Screen", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false        
        [
            label,
            button,
            playerControler,
            volumeControler
        ].forEach { testView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: testView.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor),
            
            playerControler.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            playerControler.widthAnchor.constraint(equalTo: testView.widthAnchor, multiplier: 255/335),
            playerControler.heightAnchor.constraint(equalTo: playerControler.widthAnchor, multiplier: 127/255),
            playerControler.bottomAnchor.constraint(equalTo: volumeControler.topAnchor, constant: -30),
            
            volumeControler.bottomAnchor.constraint(equalTo: testView.bottomAnchor, constant: -50),
            volumeControler.leadingAnchor.constraint(equalTo: testView.leadingAnchor, constant: 38),
            volumeControler.trailingAnchor.constraint(equalTo: testView.trailingAnchor, constant: -38),
            volumeControler.heightAnchor.constraint(equalToConstant: 16),
        ])
        view = testView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playerControler.update()
        volumeControler.update()
    }
    
    @objc private func buttonTapped(_ sender: CustomTabBarButton) {
        navigationController?.pushViewController(testVC(), animated: true)
    }
}
