//
//  SegnifyConfigurator.swift
//  Segnified
//
//  Created by Bart Hopster on 18/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

import Segnify

struct SegnifyConfigurator: SegnifyConfiguration {
    
    var equallyFillHorizontalSpace: Bool? = false
    
    var isBouncingHorizontally: Bool? = true
    
    var maximumSegmentWidth: CGFloat? = 200.0
    
    var segnifyBackgroundColor: UIColor? = .blue
}
