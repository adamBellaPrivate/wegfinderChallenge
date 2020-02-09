//
//  UIImageViewExtension.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/9/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import Nuke

extension UIImageView {

    func loadImage(with url: URL?, options: ImageLoadingOptions? = .none) {
        guard let url = url else {
            image = .none
            return
        }
        guard let options = options else {
            Nuke.loadImage(with: url, into: self)
            return
        }
        Nuke.loadImage(with: url, options: options, into: self)
    }

}
