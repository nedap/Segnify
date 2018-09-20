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
        switch state {
        case .highlighted, .selected:
            return .lightGray
        default:
            return .white
        }
    }
    
    func segmentBackgroundColor(for state: UIControl.State) -> UIColor? {
        switch state {
        case .highlighted, .selected,  [.selected, .highlighted]:
            return UIColor(red: 39.0/255.0, green: 59.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        default:
            return .clear
        }
    }
}
