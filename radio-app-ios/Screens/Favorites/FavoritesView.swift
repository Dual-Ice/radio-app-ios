//
//  FavoritesView.swift
//  radio-app-ios
//
//  Created by Andrey Zavershinskiy on 30.07.2024.
//

import UIKit

protocol FavoritesViewDelegate: AnyObject {
	func tappedButton()
}

final class FavoritesView: UIView {

	weak var delegate: FavoritesViewDelegate?

	// MARK: - Life Cycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		setViews()
		layoutViews()
		self.backgroundColor = Color.backgroundBlue
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	
	func setDelegates(_ value: FavoritesController) {
		delegate = value
	}

	private func setViews() {

	}

	private func setUpViews(){

	}


	private func layoutViews() {
		NSLayoutConstraint.activate([

		])
	}

	@objc private func buttonTapped(){
		delegate?.tappedButton()
	}
}

@available(iOS 17, *)
#Preview {
	FavoritesView()
}
