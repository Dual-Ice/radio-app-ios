//
//  VolumeControlView.swift
//  radio-app-ios
//
//  Created by nik on 08.08.24.
//

import UIKit
import AVFoundation

final class VolumeControlView: UIView {
    
    private let speakerIcon = UIImageView.makeSystemImage(
        imageName: "speaker.wave.2",
        color: .gray
    )
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = Color.customLightBlue
        
        let thumbImage = UIImage(systemName: "circle.fill")?
            .withTintColor(Color.customLightBlue)
            .resized(to: 10, 10)
        slider.setThumbImage(thumbImage, for: .normal)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let volumeLabel = UILabel.makeCustomLabel(
        key: nil,
        fontSize: 10,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .center
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstrains()
        setupTargets()
        updateVolumeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        volumeSlider.setValue(AudioPleer.shared.playerVolume, animated: false)
        updateVolumeLabel()
    }
    
    private func updateVolumeLabel() {
        volumeLabel.text = String(format: "%.0f%%", volumeSlider.value * 100)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        updateVolumeLabel()
        AudioPleer.shared.setVolume(sender.value)
    }
}

//MARK: - Setup UI
private extension VolumeControlView {
    func setupViews() {
        [
            speakerIcon,
            volumeLabel,
            volumeSlider
        ].forEach {
            addSubview($0)
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            speakerIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            speakerIcon.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            volumeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            volumeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            volumeSlider.centerYAnchor.constraint(equalTo: centerYAnchor),
            volumeSlider.leadingAnchor.constraint(equalTo: speakerIcon.trailingAnchor, constant: 16),
            volumeSlider.trailingAnchor.constraint(equalTo: volumeLabel.leadingAnchor, constant: -16),
        ])
    }
    
    func setupTargets() {
        volumeSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
}
