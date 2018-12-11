//
//  PageViewControllerProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 29/10/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// Configure a `PageViewController` instance by implementing this protocol.
/// The background color of the view and the height of its `Segnify` instance can be configured.
public protocol PageViewControllerProtocol {
    
    /// Specifies the background color of the main view.
    var backgroundColor: UIColor { get }
    
    /// Specifies the height of the `Segnify` component in `PageViewController`.
    /// The height will be realised using Auto Layout constraints.
    var segnifyHeight: CGFloat { get }
}
