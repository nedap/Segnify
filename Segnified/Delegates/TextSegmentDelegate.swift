//
//  TextSegmentDelegate.swift
//  Segnified
//
//  Created by Bart Hopster on 22/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import Segnify

/// Implements `TextSegmentProtocol`.
struct TextSegmentDelegate: TextSegmentProtocol {
    
    // MARK: - Delegate
    
    var font: UIFont = .systemFont(ofSize: 17.0)
    
    func textColor(for state: UIControl.State) -> UIColor {
        return .white
    }
    
    func segmentBackgroundColor(for state: UIControl.State) -> UIColor {
        switch state {
        case .highlighted, .selected:
            return .init(red: 0.0, green: 0.0, blue: 153.0/255.0, alpha: 1.0)
        default:
            return .blue
        }
    }
}
