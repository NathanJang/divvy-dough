//
//  FloatExtensions.swift
//  DivvyDough
//
//  Created by Jonathan Chan on 2017-10-07.
//  Copyright © 2017 Jonathan Chan. All rights reserved.
//

import Foundation

extension Float {

    var asDollars: String { return String(format: "\(self < 0 ? "-" : "")$%.2f", abs(self)) }

}
