//
//  UIViewExtension.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

extension UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    // swiftlint:disable force_cast
    class func fromNib<T: UIView>() -> T {
        let view = Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as! T
        return view
    }

}
