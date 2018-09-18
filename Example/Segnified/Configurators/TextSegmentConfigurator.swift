//
//  SegmentConfigurator.swift
//  Segnified
//
//  Created by Bart Hopster on 18/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

import Segnify

struct TextSegmentConfigurator: TextSegmentConfiguration {

    var font: UIFont? = .systemFont(ofSize: 17.0)
    
    func textColor(for state: UIControl.State) -> UIColor? {
        return .white
    }
    
    func segmentBackgroundColor(for state: UIControl.State) -> UIColor? {
        return .blue
    }
}
