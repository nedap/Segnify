//
//  Segment.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// A `Segment` instance represents a segmentation component, used by `Segnify`. It's responsible for showing any content.
/// By subclassing `UIButton`, highlighting and selecting behaviour of the `Segment` is automatically taken care of.
open class Segment: UIButton {
    
    // MARK: - Public variables
    
    public var configuration: SegmentConfiguration?
    
    // MARK: - Lifecycle
    
    public convenience init(with configuration: SegmentConfiguration?) {
        self.init(type: .custom)
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
    
    @available(*, unavailable, message: "Use init(with:) instead.")
    public convenience init(type buttonType: UIButton.ButtonType) {
        self.init(type: buttonType)
    }
    
    // MARK: - UIButton methods
    
    override open var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = configuration?.segmentBackgroundColor(for: .highlighted)
            } else {
                backgroundColor = configuration?.segmentBackgroundColor(for: isSelected ? .selected : .normal)
            }
        }
    }
    
    override open var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = configuration?.segmentBackgroundColor(for: .selected)
            } else {
                backgroundColor = configuration?.segmentBackgroundColor(for: .normal)
            }
        }
    }
}
