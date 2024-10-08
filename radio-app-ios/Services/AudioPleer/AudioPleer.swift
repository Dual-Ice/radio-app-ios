//
//  AudioPleer.swift
//  radio-app-ios
//
//  Created by nik on 01.08.24.
//

import AVFoundation

protocol AudioPleerDelegate: AnyObject {
    func showAlert(title: String, message: String)
}

final class AudioPleer {
    static let shared = AudioPleer()
    
    private var player: AVPlayer?
    private var observerStatus: NSKeyValueObservation?
    
    private(set) var isPlaying: Bool = false
    
    private(set) var playerVolume: Float = 0.1 {
        didSet {
            player?.volume = playerVolume
        }
    }
    
    private(set) var stations: [Station] = []
    private(set) var stationIndex = 0
    private(set) var currentURL = ""
    
    weak var delegate: AudioPleerDelegate?
    
    private init() {}
    
    private func loadMusic(from url: String?) {
        guard let streamURL = URL(string: url ?? "") else {
            print("Wrong stream URL: \(String(describing: url))")
            return
        }
        currentURL = url ?? ""
        
        let item = AVPlayerItem(url: streamURL)
        
        observerStatus = item.observe(\.status,
                                       changeHandler: {
            (item, value) in
            if item.status == .failed {
                print("playback failed")
                self.delegate?.showAlert(
                    title: NSLocalizedString("AudioPleerErrorTitle", comment: ""),
                    message: NSLocalizedString("AudioPleerErrorMessage", comment: "")
                )
            }
        })
        
        player = AVPlayer(playerItem: item)
        setVolume(playerVolume)
        if isPlaying { playMusic() }
    }
    
    func loadStationList(_ list: [Station]) {
        stations = list
        stationIndex = 0
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
        if (currentURL == "") {
            loadStation(at: stationIndex)
        }
        player?.play()
    }
    
    func pauseMusic() {
        isPlaying = false
        player?.pause()
    }
    
    func playNext() {
        stationIndex += 1
        if stationIndex >= stations.count { stationIndex = 0 }
        guard !stations.isEmpty else { return }
        loadStation(at: stationIndex)
    }
    
    func playPrevious() {
        stationIndex -= 1
        if stationIndex < 0 { stationIndex = stations.count - 1 }
        guard !stations.isEmpty else { return }
        loadStation(at: stationIndex)
    }
    
    func setVolume(_ value: Float) {
        playerVolume = value
    }
}
