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
    open var image: UIImage? {
        didSet {
            setImage(image, for: .normal)
        }
    }
    
    /// Sets the `ImageSegmentConfiguration` to configure the segment's appearance.
    override open var configuration: SegmentProtocol? {
        didSet {
            if let configuration = configuration as? ImageSegmentProtocol {
                // Apply the text segment configuration.
                adjustsImageWhenDisabled = configuration.adjustsImage(for: .disabled)
                adjustsImageWhenHighlighted = configuration.adjustsImage(for: .highlighted)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    public convenience init(image: UIImage?, configuration: SegmentProtocol?) {
        self.init(type: .custom)
        
        defer {
            self.configuration = configuration
            self.image = image
        }
    }
}
