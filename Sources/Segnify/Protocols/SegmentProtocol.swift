//
//  SegmentProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 12/09/2018.
//  Copyright © 2021 Bart Hopster. All rights reserved.
//

import UIKit

/// Customize any `Segment` appearance by implementing this protocol.
public protocol SegmentProtocol: AnyObject {

    /// The background color of the `Segment` instance for the different states.
    func backgroundColor(for state: UIControl.State) -> UIColor
}
