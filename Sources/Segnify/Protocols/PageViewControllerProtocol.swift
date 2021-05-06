//
//  PageViewControllerProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 29/10/2018.
//  Copyright © 2021 Bart Hopster. All rights reserved.
//

import UIKit

/// Configure a `PageViewController` instance by implementing this protocol.
/// The background color of the view and the height of its `Segnify` instance can be configured.
public protocol PageViewControllerProtocol: AnyObject {
    
    /// Specifies the background color of the main view.
    var backgroundColor: UIColor { get }
    
    /// Specifies the height of the `Segnify` component in `PageViewController`.
    /// The height will be realised using Auto Layout constraints.
    ///
    /// Please note that this property specifies the height of the `Segnify` component
    /// without taking its footer view into account.
    var segnifyHeight: CGFloat { get }
}
