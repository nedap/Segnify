//
//  SegnifyLayoutConstraint.swift
//  Segnify
//
//  Created by Bart Hopster on 11/10/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {

    /// Convenience method for activating Auto Layout constraints.
    /// This method will set `translatesAutoresizingMaskIntoConstraints` of the corresponding view to `false`, which is essential for Auto Layout to work.
    open class func activate(_ constraints: [NSLayoutConstraint], for view: UIView) {
        // We'll provide some Auto Layout constraints, so no need for translating the view's mask.
        view.translatesAutoresizingMaskIntoConstraints = false
        // Activate the constraints.
        NSLayoutConstraint.activate(constraints)
    }
}
