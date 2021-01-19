//
//  SegnicatorDelegate.swift
//  Segnified
//
//  Created by Bart Hopster on 23/11/2018.
//  Copyright © 2021 Bart Hopster. All rights reserved.
//

import UIKit
import Segnify

/// Implements `SegnicatorProtocol`.
public class SegnicatorDelegate: SegnicatorProtocol {
    
    // MARK: - Delegate
    
    public var segnicatorView: UIView {
        // Create a white, half-transparent background view.
        let backgroundView = UIView()
        backgroundView.backgroundColor = .init(white: 1.0, alpha: 0.4)
        
        // Create a white, horizontal indicator view.
        let whiteIndicatorView = UIView()
        whiteIndicatorView.backgroundColor = .white
        
        // Add it to the segnicator and give it the correct layout.
        backgroundView.addSubview(whiteIndicatorView)
        NSLayoutConstraint.activate([
            whiteIndicatorView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            whiteIndicatorView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            whiteIndicatorView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            whiteIndicatorView.heightAnchor.constraint(equalToConstant: 2.0)
        ], for: whiteIndicatorView)
        
        return backgroundView
    }
}
