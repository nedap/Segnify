//
//  ImageSegmentProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 13/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// Customize any `ImageSegment` appearance by implementing this protocol.
public protocol ImageSegmentProtocol: SegmentProtocol {

    /// Defines if the image of the `ImageSegment` instance should be adjusted for the different states.
    func isAdjustingImage(for state: UIControl.State) -> Bool
    
    /// The edge insets to be applied to the image view of the `ImageSegment` instance.
    var imageViewEdgeInsets: UIEdgeInsets { get }
    
    /// Defines the tint color of the `ImageSegment` instance.
    var tintColor: UIColor? { get }
}

extension ImageSegmentProtocol {

	/// Make `imageViewEdgeInsets` implementation by the conforming object optional by providing a default value
	public var imageViewEdgeInsets: UIEdgeInsets {
		return .zero
	}
}

