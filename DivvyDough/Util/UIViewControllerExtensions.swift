//
//  UIViewControllerExtensions.swift
//  DivvyDough
//
//  Created by Jonathan Chan on 2017-10-07.
//  Copyright © 2017 Jonathan Chan. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentAlert(message: String, animated: Bool = true) {
        let alertController = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        present(alertController, animated: animated, completion: nil)
    }

}
