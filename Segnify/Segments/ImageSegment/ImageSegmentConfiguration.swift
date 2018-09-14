//
//  ImageSegmentConfiguration.swift
//  Segnify
//
//  Created by Bart Hopster on 13/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// Customize any `ImageSegment` appearance by implementing this protocol.
public protocol ImageSegmentConfiguration: SegmentConfiguration {

    /// Defines if the image of the `ImageSegment` instance should be adjusted for the different states.
    ///
    /// The default value is `true`.
    func adjustsImage(for state: UIControlState) -> Bool?
}
