//
//  AudioPleer.swift
//  radio-app-ios
//
//  Created by nik on 01.08.24.
//

import AVFoundation

final class AudioPleer {
    private var player: AVPlayer?
    
    static let shared = AudioPleer()
    
    private(set) var isPlaying: Bool = false
    
    private init() {}
    
    func loadMusic(from url: String) {
        isPlaying = false
        guard let streamURL = URL(string: url) else {
            print("Wrong stream URL: \(url)")
            return
        }
        player = AVPlayer(url: streamURL)
    }
    
    func playMusic() {
        isPlaying = true
        player?.play()
    }
    
    func pauseMusic() {
        isPlaying = false
        player?.pause()
    }
}
