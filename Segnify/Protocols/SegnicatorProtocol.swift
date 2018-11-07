//
//  SegnicatorProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

public typealias SegnicatorSubviewsClosure = (Segnicator) -> ()

/// Customize the `Segnicator` appearance by implementing this protocol.
public protocol SegnicatorProtocol {
    
    /// Defines if the horizontal offset of the `Segnicator` instance in relation to the `Segnify` instance should be automatically updated, if a scrolling event of the content scroll view takes place.
    ///
    /// When the value is set to `true`, the offset will automatically follow any scrolling events of the content scroll view, defined by `Segnify`'s `contentScrollView` property.
    /// When the value is set to `false`, the offset will only be updated at selecting another `Segment` instance.
    var isUpdatingOffsetAtScrolling: Bool { get }
    
    /// Add one or more subviews to the `Segnicator` instance.
    var segnicatorSubviewsClosure: SegnicatorSubviewsClosure? { get }
}
