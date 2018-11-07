//
//  PageViewControllerDataSourceProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 07/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// Define the view controllers of a `PageViewController` instance by implementing this protocol.
/// and specifying the `viewControllers` array.
public protocol PageViewControllerDataSourceProtocol {

    /// The view controllers which form the content of the main view.
    /// This array shouldn't be empty in order to have a functional segmented view.
    var viewControllers: [UIViewController] { get }
}
