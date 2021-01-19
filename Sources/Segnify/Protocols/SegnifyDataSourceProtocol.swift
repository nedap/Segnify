//
//  SegnifyDataSourceProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 02/11/2018.
//  Copyright © 2021 Bart Hopster. All rights reserved.
//

import UIKit

/// A content element for a `Segnify` instance represents a tuple, containing a `Segment` instance and a corresponding `UIViewController` instance.
public typealias SegnifyContentElement = (segment: Segment, viewController: UIViewController)

/// Define the data source objects for your `Segnify` instance.
public protocol SegnifyDataSourceProtocol: class {
    
    /// The `SegnifyContentElement` instances to be shown.
    /// This array shouldn't be empty in order to have a functional `Segnify` instance.
    var contentElements: [SegnifyContentElement] { get }
}
