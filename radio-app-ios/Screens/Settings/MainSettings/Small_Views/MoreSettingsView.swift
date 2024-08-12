//
//  MoreInfo_View.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 05.08.2024.
//

import UIKit

final class MoreSettingsView: BaseSettingsView {

    // MARK: Init
    init() {
        super.init(frame: .zero, 
                   titleLabel: "More",
                   firstTitle: "LegalAndPolicies",
                   secondTitle: "AboutUs")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
