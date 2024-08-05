//
//  GeneralSettingView.swift
//  radio-app-ios
//
//  Created by Михаил Болгар on 05.08.2024.
//

import UIKit

final class GeneralSettingsView: BaseSettingsView {

    // MARK: Init
    init() {
        super.init(
            titleLabel: "General",
            firstTitle: "Notification",
            secondTitle: "Language")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
