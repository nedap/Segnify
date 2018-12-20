//
//  SegnifyProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// Customize the `Segnify` appearance by implementing this protocol.
public protocol SegnifyProtocol: class {
    
    /// The background color of the main `Segnify` component.
    var backgroundColor: UIColor { get }
    
    /// Specifies an optional footer view below the `Segnify` instance.
    var footerView: UIView { get }

    /// A Boolean value that determines whether bouncing always occurs when horizontal scrolling reaches the end of the scroll view.
    ///
    /// If this property is set to true, horizontal dragging is allowed even if the content is smaller than the bounds of the scroll view.
    var isBouncingHorizontally: Bool { get }
    
    /// Determines if the `Segment` instances, added to this `Segnify` instance, should equally fill the horizontal space available.
    ///
    /// When set to `false`, the width of every `Segment` instance is determined by `segmentWidth`, no matter if all `Segment` instances don't fit the available space.
    var isEquallyFillingHorizontalSpace: Bool { get }
    
    /// Determines if the `Segnify` instance should continue scrolling when the first or last page has been reached.
    ///
    /// When the users scrolls forward from the last page, the first page becomes visible.
    /// When the users scrolls backwards from the first page, the last page becomes visible.
    var isScrollingInfinitely: Bool { get }
    
    /// Determines the width all segments should have.
    ///
    /// The actual width of the segments might reduce, if `isEquallyFillingHorizontalSpace` is set to `true`
    /// and the segments overflow the available width, based on the `segmentWidth` value.
    var segmentWidth: CGFloat { get }
}

// MARK: - Defaults

extension SegnifyProtocol {
    
    /// Provide a default value.
    public var footerView: UIView {
        return UIView()
    }
    
    /// Provide a default value.
    public var isBouncingHorizontally: Bool {
        return true
    }
    
    /// Provide a default value.
    public var isScrollingInfinitely: Bool {
        return true
    }
}
