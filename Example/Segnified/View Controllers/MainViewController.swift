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
        // 1. Define Segnify.
        let segnify = Segnify()
        
        // 2. Add Segnify to the current view.
        view.addSubview(segnify)
        
        // 3. Give it some Auto Layout constraints.
        segnify.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.height.equalTo(75.0)
        }
        
        // 4. Define Segments.
        let textSegmentConfigurator = TextSegmentConfigurator()
        let segments = [TextSegment(with: "Test 1", configuration: textSegmentConfigurator),
                        TextSegment(with: "Test 2", configuration: textSegmentConfigurator),
                        TextSegment(with: "Test 3", configuration: textSegmentConfigurator)]
        
        // 5. Define Segnicator.
        let segnicatorConfigurator = SegnicatorConfigurator()
        let segnicator = Segnicator(with: segnicatorConfigurator)
        
        // 6. Configure Segnify.
        // Segnify needs a superview in order to being populated correctly,
        // hence the order of adding it as subview and populating and configuring it afterwards.
        let segnifyConfigurator = SegnifyConfigurator()
        segnify.populate(with: segments,
                         segnicator: segnicator,
                         segnifyConfiguration: segnifyConfigurator)
    }
}
