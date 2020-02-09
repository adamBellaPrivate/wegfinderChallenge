//
//  LocalizedLabel.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/9/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

class LocalizedLabel: UILabel {

    @IBInspectable var localizationKey: String? {
        didSet {
            uppdateTextWithLocalizationKey()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        uppdateTextWithLocalizationKey()
    }

}

private extension LocalizedLabel {

    final func uppdateTextWithLocalizationKey() {
        guard let localizationKey = localizationKey?.replacingOccurrences(of: "\"", with: ""),
            !localizationKey.isEmpty else { return }
        text = localizationKey.localized
    }

}
