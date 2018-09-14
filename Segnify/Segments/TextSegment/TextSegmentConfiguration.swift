//
//  SegmentConfiguration.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// Customize any `TextSegment` appearance by implementing this protocol.
public protocol TextSegmentConfiguration: SegmentConfiguration {
    
    /// The font of the `TextSegment` instance.
    var font: UIFont? { get set }
    
    /// The text color of the `TextSegment` instance for the different states.
    func textColor(for state: UIControlState) -> UIColor?
}
