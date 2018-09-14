//
//  Segnicator.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// An instance of `Segnicator` can be used to indicate the currently selected `Segment` instance.
/// `Segnicator` itself represents a transparent view, where one or more subviews can be added to, in order to visually indicate the currently selected `Segment`.
class Segnicator: UIView {

    // MARK: - Public variables
    
    public var segnicatorConfiguration: SegnicatorConfiguration? {
        didSet {
            if let configuration = segnicatorConfiguration {
                // Apply the segnicator configuration.
                if let segnicatorSubviews = configuration.segnicatorSubviews {
                    for subview in segnicatorSubviews {
                        addSubview(subview)
                    }
                }
                
                configuration.subviewsConstraintsClosure?()
            }
        }
    }
}
