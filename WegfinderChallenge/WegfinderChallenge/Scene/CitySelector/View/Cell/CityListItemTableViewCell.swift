//
//  CityListItemTableViewCell.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

class CityListItemTableViewCell: BaseTableViewCell {

    // MARK: - Outlets

    @IBOutlet private weak var lblCityName: UILabel!

    // MARK: - Style function

    override func performStyles() {
        super.performStyles()

        lblCityName.textColor = AppStyle.Color.textPrimary
        lblCityName.font = AppStyle.Font.medium(of: 22)
    }

    // MARK: Content manager functions

    override func clearContent() {
        super.clearContent()

        lblCityName.text = .none
    }

    final func perform(with city: Settlement) {
        lblCityName.text = city.name
    }

}
