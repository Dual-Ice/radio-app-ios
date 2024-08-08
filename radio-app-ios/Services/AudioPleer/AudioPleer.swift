//
//  AudioPleer.swift
//  radio-app-ios
//
//  Created by nik on 01.08.24.
//

import AVFoundation

final class AudioPleer {
    static let shared = AudioPleer()
    
    private var player: AVPlayer?
    
    //private var audioSession: AVAudioSession!
    
    private(set) var isPlaying: Bool = false
    
    private(set) var playerVolume: Float = 0.1 {
        didSet {
            player?.volume = playerVolume
        }
    }
    
    private init() {
        //setupAudioSession()
    }
    
    func loadMusic(from url: String) {
        isPlaying = false
        guard let streamURL = URL(string: url) else {
            print("Wrong stream URL: \(url)")
            return
        }
        player = AVPlayer(url: streamURL)
        setVolume(playerVolume)
    }
    
    func playMusic() {
        isPlaying = true
        player?.play()
    }
    
    func pauseMusic() {
        isPlaying = false
        player?.pause()
    }
    
    func setVolume(_ value: Float) {
        playerVolume = value
    }
    
//    private func setupAudioSession() {
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
//        let volume = audioSession.outputVolume
//        print("Volume changed to \(volume)")
//    }
}
