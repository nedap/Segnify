//
//  SegnicatorConfigurator.swift
//  Segnified
//
//  Created by Bart Hopster on 18/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

import Segnify

struct SegnicatorConfigurator: SegnicatorConfiguration {
    
    var isUpdatingOffsetAtScrolling: Bool? = true
    
    var segnicatorSubviewsClosure: SegnicatorSubviewsClosure? = { segnicator in
        // Create a white, horizontal indicator view.
        let whiteIndicatorView = UIView()
        whiteIndicatorView.backgroundColor = .white
        whiteIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add it to the segnicator and give it the correct layout.
        segnicator.addSubview(whiteIndicatorView)
        NSLayoutConstraint.activate([
            whiteIndicatorView.leadingAnchor.constraint(equalTo: segnicator.leadingAnchor),
            whiteIndicatorView.trailingAnchor.constraint(equalTo: segnicator.trailingAnchor),
            whiteIndicatorView.bottomAnchor.constraint(equalTo: segnicator.bottomAnchor),
            whiteIndicatorView.heightAnchor.constraint(equalToConstant: 2.0)
        ])
    }
}
