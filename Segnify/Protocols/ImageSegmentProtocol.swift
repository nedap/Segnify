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

// MARK: - Defaults

extension ImageSegmentProtocol {
    
    /// Provide a default value.
    public func isAdjustingImage(for state: UIControl.State) -> Bool {
        return false
    }

	/// Provide a default value.
	public var imageViewEdgeInsets: UIEdgeInsets {
		return .zero
	}
    
    /// Provide a default value.
    public var tintColor: UIColor? {
        return nil
    }
}

