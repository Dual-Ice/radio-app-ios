//
//  PlayerControlView.swift
//  radio-app-ios
//
//  Created by nik on 07.08.24.
//

import UIKit

protocol PlayerControlViewDelegate: AnyObject {
    func backButtonTapped()
    func centralButtonTapped()
    func nextButtonTapped()
}

final class PlayerControlView: UIView {
    private let centralButton: UIButton = UIButton.makeCustomButtonWithImage(image: Image.playerCentral!)
    
    private let playerStateView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "pause.fill")
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backButton: UIButton = UIButton.makeCustomButtonWithImage(image: Image.playerBack!)
    
    private let nextButton: UIButton = UIButton.makeCustomButtonWithImage(image: Image.playerNext!)
    
    weak var delegate: PlayerControlViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstrains()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPlayerActivity(isPlaying: Bool) {
        playerStateView.image = UIImage(
            systemName: isPlaying ? "pause.fill" : "play.fill"
        )
    }
    
    @objc private func centralButtonTapped() {
        delegate?.centralButtonTapped()
    }
    
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    @objc private func nextButtonTapped() {
        delegate?.nextButtonTapped()
    }
}

//MARK: - Setup UI
extension PlayerControlView {
    private func setupViews() {
        [
            centralButton,
            playerStateView,
            backButton,
            nextButton
        ].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            centralButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            centralButton.topAnchor.constraint(equalTo: topAnchor),
            centralButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            centralButton.widthAnchor.constraint(equalTo: centralButton.heightAnchor),
            
            playerStateView.centerXAnchor.constraint(equalTo: centralButton.centerXAnchor),
            playerStateView.centerYAnchor.constraint(equalTo: centralButton.centerYAnchor),
            playerStateView.heightAnchor.constraint(equalTo: centralButton.widthAnchor, multiplier: 37/128),
            playerStateView.widthAnchor.constraint(equalTo: playerStateView.heightAnchor),
            
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            backButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 48/127),
            
            nextButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            nextButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 48/127)
        ])
    }
    
    private func setupTargets() {
        centralButton.addTarget(self, action: #selector(centralButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
}