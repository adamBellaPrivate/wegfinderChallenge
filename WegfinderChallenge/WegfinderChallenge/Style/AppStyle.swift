//
//  AppStyle.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

enum AppStyle {

    enum Color {

        static let textPrimary = UIColor(named: "textPrimary")

    }

    enum Font {

        static func regular(of size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size)
        }

        static func medium(of size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .medium)
        }

        static func bold(of size: CGFloat) -> UIFont {
            return UIFont.boldSystemFont(ofSize: size)
        }

    }

}
