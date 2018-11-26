//
//  TextSegment.swift
//  Segnify
//
//  Created by Bart Hopster on 12/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// A `TextSegment` instance subclasses `Segment` and adds support for showing text labels.
open class TextSegment: Segment {
    
    // MARK: - Public variables
    
    /// Sets the title to use.
    open var text: String? {
        didSet {
            setTitle(text, for: .normal)
        }
    }
    
    /// Sets the `TextSegmentConfiguration` to configure the segment's appearance.
    override open var configuration: SegmentProtocol? {
        didSet {
            if let configuration = configuration as? TextSegmentProtocol {
                // Apply the text segment configuration.
                backgroundColor = configuration.segmentBackgroundColor(for: .normal)
                titleLabel?.font = configuration.font
                
                setTitleColor(configuration.textColor(for: .highlighted), for: .highlighted)
                setTitleColor(configuration.textColor(for: .normal), for: .normal)
                setTitleColor(configuration.textColor(for: .selected), for: .selected)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    public convenience init(text: String?, configuration: SegmentProtocol?) {
        self.init(type: .custom)
        
        defer {
            self.configuration = configuration
            self.text = text
        }
        
        // Setup class specific settings.
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.numberOfLines = 0
        titleLabel?.textAlignment = .center
    }
}
