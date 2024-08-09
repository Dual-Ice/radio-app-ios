//
//  StationCell.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 08.08.2024.
//

import UIKit

protocol StationCellDelegate: AnyObject {
    func tappedButton()
}

final class StationCell: UICollectionViewCell {
    
    weak var delegate: StationCellDelegate?
    
    // MARK: - Identifier
    static let identifier = StationCell.description()
    
    // MARK: - UI
    private var genreStation = UILabel.makeCustomLabelBold(
        key: "POP", // test
        fontSize: 30,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left
    )
    
    private var nameStation = UILabel.makeCustomLabel(
        key: "Radio Record", // test
        fontSize: 15,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left
    )
    
    private var imageWave = UIImageView.makeSimpleImage(
        imageName: "waveRed" // test
    )
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Reusing a cell
    override func prepareForReuse() {
        super.prepareForReuse()
        nameStation.text = nil
        genreStation.text = nil
        imageWave.image = nil
    }
    
    // MARK: - Setting Views
    private func setupView() {
        backgroundColor = .clear
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = Color.customPink.cgColor
        contentView.layer.cornerRadius = 15
        
        
        [
            genreStation,
            nameStation,
            imageWave
        ].forEach { addSubview($0) }
        
        setupConstraints()
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            nameStation.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameStation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            genreStation.topAnchor.constraint(equalTo: topAnchor, constant: 17),
            genreStation.bottomAnchor.constraint(equalTo: nameStation.topAnchor, constant: -3),
            genreStation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            
            imageWave.topAnchor.constraint(equalTo: nameStation.bottomAnchor, constant: 10),
            imageWave.leadingAnchor.constraint(equalTo: genreStation.leadingAnchor)
            
        ])
    }
}


//extension StationCell {
//    func setDelegates(_ value: StationController) {
//        delegate = value
//    }
//
//    // MARK: - @objc method
//    @objc private func buttonTapped(){
//        delegate?.tappedButton()
//    }
//}
