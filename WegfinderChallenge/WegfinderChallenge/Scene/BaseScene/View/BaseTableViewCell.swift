//
//  BaseTableViewCell.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()

        performStyles()
        clearContent()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        clearContent()
    }

    func performStyles() {}
    func clearContent() {}

}
