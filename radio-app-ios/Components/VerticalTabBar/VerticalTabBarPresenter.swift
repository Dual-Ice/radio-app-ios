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
    
    let playerControler = PlayerControlView()
    
    let volumeControler = VolumeControlView()
        
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
        
        playerControler.translatesAutoresizingMaskIntoConstraints = false
        playerControler.delegate = self
        
        volumeControler.translatesAutoresizingMaskIntoConstraints = false
        
        [
            label,
            button,
            playerControler,
            volumeControler
        ].forEach {
            testView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: testView.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor),
            
            volumeControler.bottomAnchor.constraint(equalTo: testView.bottomAnchor, constant: -50),
            volumeControler.leadingAnchor.constraint(equalTo: testView.leadingAnchor, constant: 38),
            volumeControler.trailingAnchor.constraint(equalTo: testView.trailingAnchor, constant: -38),
            volumeControler.heightAnchor.constraint(equalToConstant: 16),
            
            playerControler.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            playerControler.widthAnchor.constraint(equalTo: testView.widthAnchor, multiplier: 255/335),
            playerControler.heightAnchor.constraint(equalTo: playerControler.widthAnchor, multiplier: 127/255),
            playerControler.bottomAnchor.constraint(equalTo: volumeControler.topAnchor, constant: -30)
        ])
        view = testView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playerControler.setPlayerActivity(isPlaying: AudioPleer.shared.isPlaying)
        volumeControler.updateSliderValue(to: AudioPleer.shared.playerVolume)
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
        playerControler.setPlayerActivity(isPlaying: AudioPleer.shared.isPlaying)
    }
    
    func centralButtonTapped() {
        AudioPleer.shared.isPlaying ? AudioPleer.shared.pauseMusic() : AudioPleer.shared.playMusic()
        playerControler.setPlayerActivity(isPlaying: AudioPleer.shared.isPlaying)
    }
    
    func nextButtonTapped() {
        let state = AudioPleer.shared.isPlaying
        AudioPleer.shared.loadMusic(from: moks.randomElement() ?? "")
        state ? AudioPleer.shared.playMusic() : AudioPleer.shared.pauseMusic()
        playerControler.setPlayerActivity(isPlaying: AudioPleer.shared.isPlaying)
    }
}


//import UIKit
//import MediaPlayer
//
//class ViewController: UIViewController {
//
//    private var volumeView: MPVolumeView!
//    private var volumeObservation: NSKeyValueObservation?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupVolumeView()
//        observeVolumeChanges()
//    }
//
//    private func setupVolumeView() {
//        volumeView = MPVolumeView(frame: .zero)
//        volumeView.isHidden = true
//        view.addSubview(volumeView)
//    }
//
//    private func observeVolumeChanges() {
//        let volumeView = MPVolumeView()
//        let volumeSlider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
//        volumeObservation = volumeSlider?.observe(\.value, options: [.new]) { [weak self] slider, change in
//            guard let _ = self else { return }
//            let newVolume = slider.value
//            print("Volume changed to \(newVolume)")
//            // Handle the volume change here
//        }
//    }
//}

//import UIKit
//import AVFoundation
//
//class ViewController: UIViewController {
//
//    private var audioSession: AVAudioSession!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupAudioSession()
//    }
//
//    private func setupAudioSession() {
//        print("setupAudioSession")
//        audioSession = AVAudioSession.sharedInstance()
//        do {
//            try audioSession.setCategory(.playback, mode: .default)
//            try audioSession.setActive(true)
//            NotificationCenter.default.addObserver(
//                self,
//                selector: #selector(volumeChanged),
//                name: AVAudioSession.silenceSecondaryAudioHintNotification,
//                object: nil
//            )
//        } catch {
//            print("Failed to set up audio session: \(error)")
//        }
//    }
//
//    @objc func volumeChanged() {
//        print("volumeChanged()")
//        let volume = audioSession.outputVolume
//        print("Volume changed to \(volume)")
//    }
//
//    deinit {
//        print("deinit")
//        NotificationCenter.default.removeObserver(self)
//    }
//}
