//
//  VerticalTabBar.swift
//  radio-app-ios
//
//  Created by nik on 30.07.24.
//

import UIKit

protocol VerticalTabBarDelegate: AnyObject {
    func didSelectTab(_ sender: UIButton)
}

final class VerticalTabBar: UIView {
    
    private var buttons: [UIButton] = []
    
    private let tabBarContainer: UIView = {
        let container = UIView()
        
        #warning("заменить цвет")
        container.backgroundColor = .systemPink
        
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private var viewContainer: UIView = {
        let container = UIView()
        
        #warning("заменить цвет")
        container.backgroundColor = .blue
        
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()

        #warning("заменить цвет")
        stack.backgroundColor = .green
        
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
    
    private func createTabBarButton(_ title: String) -> UIButton {
        let button = UIButton()
        
        #warning("заменить цвет")
        button.backgroundColor = .yellow
        button.titleLabel?.text = title
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    lazy var button1 = createTabBarButton("test1")
    lazy var button2 = createTabBarButton("test2")
    lazy var button3 = createTabBarButton("test3")
    
    func addTabBarButton(_ title: String) {
        let button = createTabBarButton(title)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        buttons.append(button)
        stackView.addArrangedSubview(buttons.last ?? UIButton())
    }
    
    func showView(_ view: UIView) {
        viewContainer = view
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
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
            tabBarContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
            viewContainer.topAnchor.constraint(equalTo: topAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: tabBarContainer.trailingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: tabBarContainer.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: tabBarContainer.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: tabBarContainer.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

extension VerticalTabBar: VerticalTabBarDelegate {
    func didSelectTab(_ sender: UIButton) {
        print("VerticalTabBar: VerticalTabBarDelegate -> didSelectTab(at index: \(sender)")

    }
}
