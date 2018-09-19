//
//  ImageSegment.swift
//  Segnify
//
//  Created by Bart Hopster on 13/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// A `ImageSegment` instance subclasses `Segment` and adds support for showing images.
open class ImageSegment: Segment {
    
    // MARK: - Public variables
    
    /// Sets the title to use.
    public var image: UIImage? {
        didSet {
            setImage(image, for: .normal)
        }
    }
    
    /// Sets the `ImageSegmentConfiguration` to configure the segment's appearance.
    override open var configuration: SegmentConfiguration? {
        didSet {
            if let configuration = configuration as? ImageSegmentConfiguration {
                // Apply the text segment configuration.
                adjustsImageWhenDisabled = configuration.adjustsImage(for: .disabled) ?? true
                adjustsImageWhenHighlighted = configuration.adjustsImage(for: .highlighted) ?? true
            }
        }
    }
    
    // MARK: - Lifecycle
    
    public convenience init(with image: UIImage?, configuration: SegmentConfiguration?) {
        self.init(type: .custom)
        
        defer {
            self.configuration = configuration
            self.image = image
        }
    }
}
