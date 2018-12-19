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
    
    open weak var configuration: SegnicatorProtocol? {
        didSet {
            if let configuration = configuration {
                // Apply the segnicator configuration.
                let segnicatorView = configuration.segnicatorView
                addSubview(segnicatorView)
                // Apply Auto Layout constraints.
                NSLayoutConstraint.activate([
                    segnicatorView.topAnchor.constraint(equalTo: topAnchor),
                    segnicatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    segnicatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
                    segnicatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
                    ], for: segnicatorView)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    public convenience init(configuration: SegnicatorProtocol?) {
        self.init()
        
        defer {
            // Ignore any touches and events, so it's not blocking any touches or events meant for a segment.
            isUserInteractionEnabled = false
            // Set the configuration.
            self.configuration = configuration
        }
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
