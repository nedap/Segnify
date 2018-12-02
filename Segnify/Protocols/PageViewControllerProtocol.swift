//
//  PageViewControllerProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 29/10/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// A closure for adding one or more subviews to the `bannerView` instance of `PageViewController`
/// and adding Auto Layout constraints to them.
public typealias BannerViewClosure = () -> ()

/// Configure a `PageViewController` instance by implementing this protocol.
/// The background color of the view and the height of its `Segnify` instance can be configured.
public protocol PageViewControllerProtocol {
    
    /// Specifies the background color of the main view.
    var backgroundColor: UIColor { get }
    
    /// Add one or more subviews to the `bannerView` instance of `PageViewController`.
    var bannerViewClosure: BannerViewClosure { get }
    
    /// Specifies the height of the `bannerView` instance.
    var bannerViewHeight: CGFloat { get }
    
    /// Specifies the height of the `Segnify` component in `PageViewController`.
    /// The height will be realised using Auto Layout constraints.
    var segnifyHeight: CGFloat { get }
}

// MARK: - Defaults

extension PageViewControllerProtocol {
    
    /// Provide a default value.
    public var bannerViewClosure: BannerViewClosure {
        return {}
    }
    
    /// Provide a default value.
    public var bannerViewHeight: CGFloat {
        return 0.0
    }
}
