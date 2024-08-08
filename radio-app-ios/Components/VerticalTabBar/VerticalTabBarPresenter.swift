//
//  VerticalTabBarPresenter.swift
//  radio-app-ios
//
//  Created by nik on 30.07.24.
//

import UIKit

protocol VerticalTabBarPresenterProtocol: AnyObject {
    func loadViewController()
    func didChooseView(_ view: String)
}

final class VerticalTabBarPresenter: VerticalTabBarPresenterProtocol {
    private unowned let tabBarController: VerticalTabBarControllerProtocol
    
    //MARK: - Modules. Enter here the name and class of the controllers to display
    private let viewControllers: [String: UIViewController] = [
        "Popular"       : testVC(),
        "Favorites"     : testVC(),
        "AllStations"   : testVC()
    ]
        
    init(tabBarController: VerticalTabBarControllerProtocol) {
        self.tabBarController = tabBarController
    }
    
    func loadViewController() {
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
    
    let moks: [String] = [
        "https://0n-jazz.radionetz.de/0n-jazz.mp3",
        "https://stream.rockantenne.de/alternative/stream/mp3",
        "https://stream.zeno.fm/fu24r3f24c9uv",
        "https://stream-176.zeno.fm/a3th9bd1fs8uv?zs=e8ersugnTZy8yQsXXp2s2A",
        "https://drive.uber.radio/uber/crberlinphilharmonic/icecast.audio"
    ]
    
    let controler = PlayerControlView()
        
    override func loadView() {
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
        
        controler.translatesAutoresizingMaskIntoConstraints = false
        controler.delegate = self
        
        [
            label,
            button,
            controler
        ].forEach {
            testView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: testView.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor),
            
            controler.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            controler.widthAnchor.constraint(equalTo: testView.widthAnchor, multiplier: 255/335),
            controler.heightAnchor.constraint(equalTo: controler.widthAnchor, multiplier: 127/255),
            controler.bottomAnchor.constraint(equalTo: testView.bottomAnchor, constant: -75)
        ])
        view = testView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controler.setPlayerActivity(isPlaying: AudioPleer.shared.isPlaying)
    }
    
    @objc private func buttonTapped(_ sender: CustomTabBarButton) {
        navigationController?.pushViewController(testVC(), animated: true)
    }
    
    @objc private func playButtonTapped(_ sender: CustomTabBarButton) {
        let url = moks.randomElement()
        AudioPleer.shared.loadMusic(from: url ?? "")
        AudioPleer.shared.playMusic()
    }
    
    @objc private func pauseButtonTapped(_ sender: CustomTabBarButton) {
        AudioPleer.shared.pauseMusic()
    }
}

extension testVC: PlayerControlViewDelegate {
    func backButtonTapped() {
        AudioPleer.shared.loadMusic(from: moks.randomElement() ?? "")
        controler.setPlayerActivity(isPlaying: AudioPleer.shared.isPlaying)
    }
    
    func centralButtonTapped() {
        AudioPleer.shared.isPlaying ? AudioPleer.shared.pauseMusic() : AudioPleer.shared.playMusic()
        controler.setPlayerActivity(isPlaying: AudioPleer.shared.isPlaying)
    }
    
    func nextButtonTapped() {
        let state = AudioPleer.shared.isPlaying
        AudioPleer.shared.loadMusic(from: moks.randomElement() ?? "")
        state ? AudioPleer.shared.playMusic() : AudioPleer.shared.pauseMusic()
        controler.setPlayerActivity(isPlaying: AudioPleer.shared.isPlaying)
    }
}
