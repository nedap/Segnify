//
//  TextSegmentProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2021 Bart Hopster. All rights reserved.
//

import UIKit

/// Customize any `TextSegment` appearance by implementing this protocol.
public protocol TextSegmentProtocol: SegmentProtocol {
    
    /// The font of the `TextSegment` instance.
    var font: UIFont { get }
    
    /// The text color of the `TextSegment` instance for the different states.
    func textColor(for state: UIControl.State) -> UIColor
}
