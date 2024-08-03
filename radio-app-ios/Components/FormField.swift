//
//  FormField.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 03.08.2024.
//

import UIKit

final class FormField: UIView {
    
    // MARK: - UI Elements
    private let label: UILabel
    private let textField: UITextField
    
    init(labelText: String, placeholder: String, isSecure: Bool) {
        label = UILabel.makeCustomLabel(
            key: labelText,
            fontSize: Constants.regularLabelSize,
            textColor: .white,
            numberOfLines: nil,
            textAligment: .left
        )
        
        textField = UITextField.makeCustomPinkTextfield(placeholderText: placeholder, isSecure: isSecure)
        
        super.init(frame: .zero)
        
        setUpViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getFieldValue() -> String {
        return textField.text ?? ""
    }
    
    // MARK: - Setup Views
    
    private func setUpViews() {
        addSubview(label)
        addSubview(textField)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Constants.topOffset),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight)
        ])
    }
}

