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
                // Apply the image segment configuration.
                adjustsImageWhenDisabled = configuration.isAdjustingImage(for: .disabled)
                adjustsImageWhenHighlighted = configuration.isAdjustingImage(for: .highlighted)
                backgroundColor = configuration.backgroundColor(for: .normal)
                imageEdgeInsets = configuration.imageViewEdgeInsets
				
                if let tintColor = configuration.tintColor {
                    self.tintColor = tintColor
                }
            }
        }
    }
    
    // MARK: - Lifecycle
    
    public convenience init(image: UIImage?, configuration: SegmentProtocol?) {
        self.init(type: .custom)
        
        imageView?.contentMode = .scaleAspectFit
        
        defer {
            self.configuration = configuration
            self.image = image
        }
    }
    
    @available(*, unavailable, message: "Use init(image:configuration:) instead.")
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable, message: "Use init(image:configuration:) instead.")
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
