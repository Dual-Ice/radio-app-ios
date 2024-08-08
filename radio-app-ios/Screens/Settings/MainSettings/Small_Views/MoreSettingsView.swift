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
        super.init(titleLabel: "More",
                   firstTitle: "Legal and Policies",
                   secondTitle: "About Us")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
