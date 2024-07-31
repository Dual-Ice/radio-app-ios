//
//  VerticalTabBar.swift
//  radio-app-ios
//
//  Created by nik on 30.07.24.
//

import UIKit

protocol VerticalTabBarDelegate: AnyObject {
    func didSelectTab(_ sender: CustomTabBarButton)
}

final class VerticalTabBar: UIView {
    private let tabBarContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .systemPink
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .green
        stack.axis = .horizontal
        stack.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -2)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var buttons: [CustomTabBarButton] = []
    
    var viewContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .blue
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    weak var delegate: VerticalTabBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func addTabBarButton(_ title: String, identifier: ViewType) {
        let button = CustomTabBarButton(lableText: title, identifier: identifier)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        buttons.append(button)
        stackView.addArrangedSubview(button)
    }
    
    @objc private func buttonTapped(_ sender: CustomTabBarButton) {
        delegate?.didSelectTab(sender)
    }
}

//MARK: - Setup UI
private extension VerticalTabBar {
    func setupViews() {
        [
            tabBarContainer,
            viewContainer,
            stackView
        ].forEach { addSubview($0) }
    }
    
    func setupConstrains() {
        
        NSLayoutConstraint.activate([
            tabBarContainer.topAnchor.constraint(equalTo: topAnchor),
            tabBarContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            tabBarContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            tabBarContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.19),
            
            viewContainer.topAnchor.constraint(equalTo: topAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: tabBarContainer.trailingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: tabBarContainer.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: tabBarContainer.centerXAnchor)
        ])
    }
}
