//
//  TextSegmentDelegate.swift
//  Segnified
//
//  Created by Bart Hopster on 22/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit
import Segnify

/// Implements `TextSegmentProtocol`.
public class TextSegmentDelegate: TextSegmentProtocol {
    
    // MARK: - Delegate
    
    public func backgroundColor(for state: UIControl.State) -> UIColor {
        return .nedapOrange
    }
    
    public var font: UIFont = .systemFont(ofSize: 17.0)
    
    public func textColor(for state: UIControl.State) -> UIColor {
        return .nedapDarkBlue
    }
}
