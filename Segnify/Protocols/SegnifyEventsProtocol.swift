//
//  SegnifyEventsProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 30/10/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// Get informed by `Segnify` events, i.e. segment selection, by implementing this protocol.
internal protocol SegnifyEventsProtocol: class {

    /// Inform the delegate about `Segment` selection changes.
    func didSelect(segment: Segment, of segnify: Segnify, previousIndex: Int?, currentIndex: Int)
}
