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
        "Popular"       : testVC1(),
        "Favorites"     : testVC2(),
        "AllStations"   : testVC3()
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
class testVC1: UIViewController {
    
    let moks: [String] = [
        "https://0n-jazz.radionetz.de/0n-jazz.mp3",
        "https://stream.rockantenne.de/alternative/stream/mp3",
        "https://stream.zeno.fm/fu24r3f24c9uv",
        "https://stream-176.zeno.fm/a3th9bd1fs8uv?zs=e8ersugnTZy8yQsXXp2s2A",
        "https://drive.uber.radio/uber/crberlinphilharmonic/icecast.audio"
    ]
    
    override func loadView() {
        let testView = UIView()
        testView.backgroundColor = .green
        let label = UILabel()
        label.text = "testVC1"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton()
        button.setTitle("Tap Me", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let playButton = UIButton()
        playButton.setTitle("PLAY RANDOM", for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        let pauseButton = UIButton()
        pauseButton.setTitle("PAUSE", for: .normal)
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        testView.addSubview(label)
        testView.addSubview(button)
        testView.addSubview(playButton)
        testView.addSubview(pauseButton)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: testView.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor),
            playButton.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: button.bottomAnchor),
            pauseButton.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            pauseButton.topAnchor.constraint(equalTo: playButton.bottomAnchor),
        ])
        view = testView
    }
    
    @objc private func buttonTapped(_ sender: CustomTabBarButton) {
        navigationController?.pushViewController(FinalVC(), animated: true)
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

class testVC2: UIViewController {
    override func loadView() {
        let testView = UIView()
        testView.backgroundColor = .yellow
        let label = UILabel()
        label.text = "testVC2"
        label.translatesAutoresizingMaskIntoConstraints = false
        testView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: testView.centerYAnchor)
        ])
        view = testView
    }
}

class testVC3: UIViewController {
    override func loadView() {
        let testView = UIView()
        testView.backgroundColor = .blue
        let label = UILabel()
        label.text = "testVC3"
        label.translatesAutoresizingMaskIntoConstraints = false
        testView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: testView.centerYAnchor)
        ])
        view = testView
    }
}

class FinalVC: UIViewController {
    override func loadView() {
        let testView = UIView()
        testView.backgroundColor = .cyan
        let label = UILabel()
        label.text = "FinalVC"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let playButton = UIButton()
        playButton.setTitle("PLAY", for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        let pauseButton = UIButton()
        pauseButton.setTitle("PAUSE", for: .normal)
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        testView.addSubview(label)
        testView.addSubview(playButton)
        testView.addSubview(pauseButton)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: testView.centerYAnchor),
            playButton.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: label.bottomAnchor),
            pauseButton.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            pauseButton.topAnchor.constraint(equalTo: playButton.bottomAnchor)
        ])
        view = testView
    }
    
    @objc private func playButtonTapped(_ sender: CustomTabBarButton) {
        AudioPleer.shared.playMusic()
    }
    
    @objc private func pauseButtonTapped(_ sender: CustomTabBarButton) {
        AudioPleer.shared.pauseMusic()
    }
}
