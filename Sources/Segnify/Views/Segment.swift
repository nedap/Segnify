//
//  Segment.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2021 Bart Hopster. All rights reserved.
//

import UIKit

/// A `Segment` instance represents a segmentation component, used by `Segnify`. It's responsible for showing any content.
/// By subclassing `UIButton`, highlighting and selecting behaviour of the `Segment` is automatically taken care of.
open class Segment: UIButton {
    
    // MARK: - Public variables
    
    open weak var configuration: SegmentProtocol?
    
    // MARK: - UIButton methods
    
    override open var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = configuration?.backgroundColor(for: .highlighted)
            } else {
                backgroundColor = configuration?.backgroundColor(for: isSelected ? .selected : .normal)
            }
        }
    }
    
    override open var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = configuration?.backgroundColor(for: .selected)
            } else {
                backgroundColor = configuration?.backgroundColor(for: .normal)
            }
        }
    }
}
