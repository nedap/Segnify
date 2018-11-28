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
    
    var backgroundColor: UIColor = .white
    
    var isEquallyFillingHorizontalSpace: Bool = false
    
    var segmentWidth: CGFloat = 175.0
}
