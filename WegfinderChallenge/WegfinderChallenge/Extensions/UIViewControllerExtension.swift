//
//  UIViewControllerExtension.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

extension UIViewController {

    func embedInNavigationController(isHidden: Bool = false) -> UINavigationController {
        guard let navigationController = self as? UINavigationController else {
            let navigationController = UINavigationController(rootViewController: self)
            navigationController.navigationBar.isHidden = isHidden
            return navigationController
        }

        navigationController.navigationBar.isHidden = isHidden
        return navigationController
    }

    func simpleAlert(with title: String? = .none, message: String? = .none) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "button.ok.title".localized, style: .cancel)
        alertView.addAction(cancelAction)

        present(alertView, animated: true, completion: .none)
    }

}
