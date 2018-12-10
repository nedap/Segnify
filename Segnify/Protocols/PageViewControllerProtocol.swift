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
/// A footer view can be configured as well.
public protocol PageViewControllerProtocol {
    
    /// Specifies the background color of the main view.
    var backgroundColor: UIColor { get }
    
    /// Specifies an optional footer view below the `Segnify` instance.
    var footerView: UIView { get }
    
    /// Specifies the height of the footer view below the `Segnify` instance.
    var footerViewHeight: CGFloat { get }
    
    /// Specifies the height of the `Segnify` component in `PageViewController`.
    /// The height will be realised using Auto Layout constraints.
    var segnifyHeight: CGFloat { get }
}

// MARK: - Defaults

extension PageViewControllerProtocol {
    
    /// Provide a default value.
    public var footerView: UIView {
        return UIView()
    }
    
    public var footerViewHeight: CGFloat {
        return 0.0
    }
}
