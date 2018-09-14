//
//  SegnicatorConfiguration.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

public typealias ConstraintsClosure = () -> Void

/// Customize the `Segnicator` appearance by implementing this protocol.
public protocol SegnicatorConfiguration {
    
    /// Adds the specified subviews to the `Segnicator` instance.
    var segnicatorSubviews: [UIView]? { get set }
    
    /// Configures the `segnicatorSubviews` using one or more Auto Layout constraints.
    var subviewsConstraintsClosure: ConstraintsClosure? { get set }
}
