//
//  ViewController.swift
//  Segnified
//
//  Created by Bart Hopster on 17/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

import Segnify

class MainViewController: UIViewController {
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Add Segnify to the current view.
        setupSubviews()
    }
}

// MARK: - Segnify configuration

extension MainViewController {
    
    private func setupSubviews() {
        // 1. Define Segments.
        let textSegmentConfigurator = TextSegmentConfigurator()
        let segments = [TextSegment(with: "Test 1", configuration: textSegmentConfigurator),
                        TextSegment(with: "Test 2", configuration: textSegmentConfigurator),
                        TextSegment(with: "Test 3", configuration: textSegmentConfigurator)]
        
        // 2. Define Segnicator.
        let segnicatorConfigurator = SegnicatorConfigurator()
        let segnicator = Segnicator(with: segnicatorConfigurator)
        
        // 3. Define Segnify.
        let segnifyConfigurator = SegnifyConfigurator()
        let segnify = Segnify(with: segments,
                              segnicator: segnicator,
                              segnifyConfiguration: segnifyConfigurator)
        
        // 4. Add Segnify to the current view.
        view.addSubview(segnify)
        
        // 5. Give it some Auto Layout constraints.
        segnify.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(44.0)
        }
    }
}
