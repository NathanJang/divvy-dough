//
//  UITableViewExtensions.swift
//  DivvyDough
//
//  Created by Jonathan Chan on 2017-10-07.
//  Copyright © 2017 Jonathan Chan. All rights reserved.
//

import UIKit

extension UITableView {

    func deselectSelectedRow(animated: Bool) {
        if let selectedIndexPath = indexPathForSelectedRow { deselectRow(at: selectedIndexPath, animated: animated) }
    }

}
