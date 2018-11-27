//
//  ImageSegmentDelegate.swift
//  Segnified
//
//  Created by Bart Hopster on 22/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import Segnify

/// Implements `ImageSegmentProtocol`.
struct ImageSegmentDelegate: ImageSegmentProtocol {
    
    // MARK: - Delegate
    
    func isAdjustingImage(for state: UIControl.State) -> Bool {
        return false
    }
    
    var imageViewEdgeInsets: UIEdgeInsets? {
        return .init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    func segmentBackgroundColor(for state: UIControl.State) -> UIColor {
        return .orange
    }
}
