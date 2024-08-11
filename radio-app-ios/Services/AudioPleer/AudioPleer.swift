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
    
    private var stations: [Station] = []
    private var stationIndex = 0
    
    private init() {}
    
    private func loadMusic(from url: String?) {
        guard let streamURL = URL(string: url ?? "") else {
            print("Wrong stream URL: \(String(describing: url))")
            return
        }
        player = AVPlayer(url: streamURL)
        setVolume(playerVolume)
        if isPlaying { playMusic() }
    }
    
    func loadStationList(_ list: [Station]) {
        stations = list
        stationIndex = -1
    }
    
    func loadStation(at index: Int) {
        guard index >= 0, index < stations.count else {
            print("Index our of range!")
            return
        }
        stationIndex = index
        loadMusic(from: stations[index].url)
    }
    
    func playMusic() {
        isPlaying = true
        player?.play()
    }
    
    func pauseMusic() {
        isPlaying = false
        player?.pause()
    }
    
    func playNext() {
        stationIndex += 1
        if stationIndex >= stations.count { stationIndex = 0 }
        loadMusic(from: stations[stationIndex].url)
    }
    
    func playPrevious() {
        stationIndex -= 1
        if stationIndex < 0 { stationIndex = stations.count - 1 }
        loadMusic(from: stations[stationIndex].url)
    }
    
    func setVolume(_ value: Float) {
        playerVolume = value
    }
}
