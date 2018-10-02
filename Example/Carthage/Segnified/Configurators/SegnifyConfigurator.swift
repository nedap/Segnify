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
    
    var maximumSegmentWidth: CGFloat? = 150.0
    
    var segnifyBackgroundColor: UIColor? = UIColor(red: 76.0/255.0, green: 114.0/255.0, blue: 128.0/255.0, alpha: 1.0)
}
