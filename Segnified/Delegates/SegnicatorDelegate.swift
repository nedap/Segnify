//
//  SegnicatorDelegate.swift
//  Segnified
//
//  Created by Bart Hopster on 23/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import Segnify

/// Implements `SegnicatorProtocol`.
struct SegnicatorDelegate: SegnicatorProtocol {
    
    // MARK: - Delegate
    
    var segnicatorSubviewsClosure: SegnicatorSubviewsClosure {
        return { segnicator in
            // Create a white, half-transparent background view.
            let backgroundView = UIView()
            backgroundView.backgroundColor = .init(white: 1.0, alpha: 0.4)
            
            // Add it to the segnicator and give it the correct layout.
            segnicator.addSubview(backgroundView)
            NSLayoutConstraint.activate([
                backgroundView.topAnchor.constraint(equalTo: segnicator.topAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: segnicator.leadingAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: segnicator.bottomAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: segnicator.trailingAnchor)
                ], for: backgroundView)
            
            // Create a white, horizontal indicator view.
            let whiteIndicatorView = UIView()
            whiteIndicatorView.backgroundColor = .white
            
            // Add it to the segnicator and give it the correct layout.
            segnicator.addSubview(whiteIndicatorView)
            NSLayoutConstraint.activate([
                whiteIndicatorView.leadingAnchor.constraint(equalTo: segnicator.leadingAnchor),
                whiteIndicatorView.bottomAnchor.constraint(equalTo: segnicator.bottomAnchor),
                whiteIndicatorView.trailingAnchor.constraint(equalTo: segnicator.trailingAnchor),
                whiteIndicatorView.heightAnchor.constraint(equalToConstant: 2.0)
                ], for: whiteIndicatorView)
        }
    }
}
