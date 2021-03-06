//
//  DefaultImageSegmentDelegate.swift
//  Segnify
//
//  Created by Bart Hopster on 27/11/2018.
//  Copyright © 2021 Bart Hopster. All rights reserved.
//

import UIKit

/// Provides a default implementation for `ImageSegmentProtocol`.
public class DefaultImageSegmentDelegate: ImageSegmentProtocol {
    
    // MARK: - Delegate
    
    public func backgroundColor(for state: UIControl.State) -> UIColor {
        switch state {
        case .highlighted, .selected,  [.selected, .highlighted]:
            return .init(red: 39.0/255.0, green: 59.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        default:
            return .clear
        }
    }
}
