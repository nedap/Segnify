//
//  Configuration.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// Customize the `Segnify` appearance by implementing this protocol.
public protocol SegnifyConfiguration {

    /// Determines if the `Segment` instances, added to this `Segnify` instance, should equally fill the horizontal space available.
    ///
    /// When set to `false`, the width of every `Segment` instance is determined by `segmentWidth`, no matter if all `Segment` instances don't fit the available space.
    ///
    /// The default value is `true`.
    var equallyFillHorizontalSpace: Bool? { get set }
    
    /// A Boolean value that determines whether bouncing always occurs when horizontal scrolling reaches the end of the scroll view.
    ///
    /// If this property is set to true, horizontal dragging is allowed even if the content is smaller than the bounds of the scroll view.
    ///
    /// The default value is `true`.
    var isBouncingHorizontally: Bool? { get set }
    
    /// Determines the width all segments should have.
    ///
    /// The actual width of the segments might reduce, if `equallyFillHorizontalSpace` is set to `true` and the segments overflow the available width, based on the `segmentWidth` value.
    ///
    /// The default value is 200.0.
    var segmentWidth: CGFloat? { get set }
    
    /// The background color of the main `Segnify` component.
    var segnifyBackgroundColor: UIColor? { get set }
}
