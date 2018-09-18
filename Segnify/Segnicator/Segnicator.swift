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
open class Segnicator: UIView {

    // MARK: - Public variables
    
    public var configuration: SegnicatorConfiguration? {
        didSet {
            if let configuration = configuration {
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
    
    // MARK: - Lifecycle
    
    public convenience init(with configuration: SegnicatorConfiguration?) {
        self.init()
        self.configuration = configuration
    }
    
    @available(*, unavailable, message: "Use init(with:) instead.")
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable, message: "Use init(with:) instead.")
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
