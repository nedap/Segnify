//
//  SegnifyDelegate.swift
//  Segnified
//
//  Created by Bart Hopster on 23/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import Segnify

/// Implements `SegnifyProtocol`.
struct SegnifyDelegate: SegnifyProtocol {
    
    // MARK: - Delegate
    
    var equallyFillHorizontalSpace: Bool = false

    var isBouncingHorizontally: Bool = true
    
    var segmentWidth: CGFloat = 175.0
    
    var segnifyBackgroundColor: UIColor = .init(white: 0.2, alpha: 1.0)
}
