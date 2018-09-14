//
//  TextSegment.swift
//  Segnify
//
//  Created by Bart Hopster on 12/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// A `TextSegment` instance subclasses `Segment` and adds support for showing text labels.
class TextSegment: Segment {
    
    // MARK: - Public variables
    
    /// Sets the title to use.
    public var text: String? {
        didSet {
            setTitle(text, for: .normal)
        }
    }
    
    /// Sets the `TextSegmentConfiguration` to configure the segment's appearance.
    override var configuration: SegmentConfiguration? {
        didSet {
            if let configuration = configuration as? TextSegmentConfiguration {
                // Apply the text segment configuration.
                titleLabel?.font = configuration.font
                
                setTitleColor(configuration.textColor(for: .highlighted), for: .highlighted)
                setTitleColor(configuration.textColor(for: .normal), for: .normal)
                setTitleColor(configuration.textColor(for: .selected), for: .selected)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    convenience init() {
        self.init()
        
        // Setup class specific settings.
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.numberOfLines = 0
        titleLabel?.textAlignment = .center
    }
}
