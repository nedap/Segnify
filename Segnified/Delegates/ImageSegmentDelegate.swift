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
    
    func adjustsImage(for state: UIControl.State) -> Bool {
        return false
    }
    
    var imageViewInsets: UIEdgeInsets {
        return .init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    func segmentBackgroundColor(for state: UIControl.State) -> UIColor {
        switch state {
        case .highlighted, .selected:
            return .orange
        default:
            return .init(red: 1.0, green: 1.0, blue: 127.0/255.0, alpha: 1.0)
        }
    }
}
