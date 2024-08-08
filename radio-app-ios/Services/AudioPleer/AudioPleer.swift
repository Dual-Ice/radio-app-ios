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
    
    private(set) var isPlaying: Bool = false
    
    private(set) var playerVolume: Float = 0.1 {
        didSet {
            player?.volume = playerVolume
        }
    }
    
    private init() {}
    
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
}
