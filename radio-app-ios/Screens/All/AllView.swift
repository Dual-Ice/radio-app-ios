//
//  AllView.swift
//  radio-app-ios
//
//  Created by Дмитрий Волков on 07.08.2024.
//

import UIKit

protocol AllViewDelegate: AnyObject {
    func tappedButton()
}

final class AllView: UIView {
    weak var delegate: AllViewDelegate?
    
    // MARK: - UI
    
    private let bgImage = UIImageView.makeSimpleImage(imageName: "signInBackground")
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegates(_ value: AllController) {
        delegate = value
    }
    
    // MARK: - Set Views
    
    private func setViews() {
        
        self.backgroundColor = Color.backgroundBlue
        
        self.addSubview(bgImage)
        
//        [
//        ].forEach { bgImage.addSubview($0) }
        
        
        
        setUpViews()
    }
    
    private func setUpViews(){
    }
    
    @objc private func buttonTapped(){
        delegate?.tappedButton()
    }
    
    
    // MARK: - Setup Constraints
    
    private func setCommonLayouts() {
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: self.topAnchor),
            bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bgImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bgImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
        ])
    }
    
    private func layoutViews() {
       setCommonLayouts()
    }
}
