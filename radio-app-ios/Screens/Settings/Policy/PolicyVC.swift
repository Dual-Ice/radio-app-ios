//
//  Policy.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 30.07.2024.
//

import UIKit

final class PolicyVC: UIViewController {

    // MARK: UI Elements

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private let backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = Image.signInBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let firstTitleLabel = UILabel.makeCustomLabelBold(
        key: "Terms",
        fontSize: 14,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left)

    private let secondTitleLabel = UILabel.makeCustomLabelBold(
        key: "Changes to the Service and/or Terms",
        fontSize: 14,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left)

    private let firstTextLabel = UILabel.makeCustomLabelBold(
        key: "MockText",
        fontSize: 14,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left)

    private let secondTextLabel = UILabel.makeCustomLabelBold(
        key: "MockText",
        fontSize: 14,
        textColor: .white,
        numberOfLines: 1,
        textAligment: .left)


    // MARK: Life cycle

    override func viewDidLoad() {
        
    }
}


private extension PolicyVC {

    func setView() {

        view.addSubview(scrollView)
        [backgroundView, stackView].forEach { scrollView.addSubview($0) }
       
        [firstTextLabel,
         firstTextLabel,
         secondTitleLabel,
         secondTextLabel].forEach { stackView.addArrangedSubview($0) }
    }

    func setupConstraints() {
        
    }
}
