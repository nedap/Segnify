//
//  SegnicatorProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// A closure with a reference to a `Segnicator` instance, in order to add one or more subviews to that `Segnicator` instance.
public typealias SegnicatorSubviewsClosure = (Segnicator) -> ()

/// Customize the `Segnicator` appearance by implementing this protocol.
public protocol SegnicatorProtocol {
    
    /// Add one or more subviews to the `Segnicator` instance.
    var segnicatorSubviewsClosure: SegnicatorSubviewsClosure? { get }
}
