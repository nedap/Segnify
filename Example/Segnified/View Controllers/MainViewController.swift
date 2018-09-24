//
//  ViewController.swift
//  Segnified
//
//  Created by Bart Hopster on 17/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

import Segnify

class MainViewController: UIViewController, SegnifyDelegate {
    
    // MARK: - Private variables
    
    private lazy var contentScrollView: UIScrollView = {
        let contentScrollView = UIScrollView()
        contentScrollView.isPagingEnabled = true
        contentScrollView.showsHorizontalScrollIndicator = false
        return contentScrollView
    }()
    
    private let segmentTitles = ["Segment 1", "Segment 2", "Segment 3"]
    private let segnify = Segnify()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Add Segnify to the current view.
        setupSegnify()
        setupContentScrollView()
    }
}

// MARK: - Segnify configuration

extension MainViewController {
    
    private func setupSegnify() {
        // 1. Add Segnify to the current view.
        view.addSubview(segnify)
        
        // 2. Give it some Auto Layout constraints.
        segnify.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.height.equalTo(75.0)
        }
        
        // 3. Define Segments.
        let textSegmentConfigurator = TextSegmentConfigurator()
        let segments = segmentTitles.map({ TextSegment(with: $0, configuration: textSegmentConfigurator) })
        
        // 4. Define Segnicator.
        let segnicatorConfigurator = SegnicatorConfigurator()
        let segnicator = Segnicator(with: segnicatorConfigurator)
        
        // 5. Configure Segnify.
        // Segnify needs a superview in order to being populated correctly,
        // hence the order of adding it as subview and populating and configuring it afterwards.
        let segnifyConfigurator = SegnifyConfigurator()
        segnify.contentScrollView = contentScrollView
        segnify.delegate = self
        segnify.populate(with: segments,
                         segnicator: segnicator,
                         segnifyConfiguration: segnifyConfigurator)
    }
}

// MARK: - Scroll view configuration

extension MainViewController {
    
    private func setupContentScrollView() {
        // Use contentScrollView to show the Segnify functionality.
        // Add it as a subview and give it some constraints.
        view.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.segnify.snp.bottom)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
        
        // Create a new stack view ...
        let contentStackView = UIStackView()
        contentStackView.alignment = .fill
        contentStackView.axis = .horizontal
        contentStackView.distribution = .equalSpacing
        contentStackView.spacing = 0.0
        // ... add it to the scroll view ...
        contentScrollView.addSubview(contentStackView)
        // ... and give it the correct layout.
        contentStackView.snp.makeConstraints { make in
            make.edges.height.equalToSuperview()
        }
        
        // Add some subviews to the stack view.
        for segmentTitle in segmentTitles {
            // Initialize a view ...
            let subview = UIView()
            // ... add it to the stack view ...
            contentStackView.addArrangedSubview(subview)
            // ... and give it the correct layout.
            subview.snp.makeConstraints { make in
                make.width.equalTo(self.contentScrollView.snp.width)
            }
            
            // Define a text label, in order to distinguish the various views.
            let textLabel = UILabel()
            textLabel.text = segmentTitle
            textLabel.textAlignment = .center
            
            // Add it to the view ...
            subview.addSubview(textLabel)
            // ... and give it the correct layout.
            textLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}

// MARK: - Segnify delegate

extension MainViewController {
    
    func segnify(_ segnify: Segnify, didSelect segment: Segment, with index: Int) {
        // Scroll the content scroll view to the corresponding 'page'.
        contentScrollView.setContentOffset(CGPoint(x: (CGFloat(index) * contentScrollView.frame.width), y: 0.0), animated: true)
    }
}
