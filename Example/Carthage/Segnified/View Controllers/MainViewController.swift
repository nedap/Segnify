//
//  MainViewController.swift
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
        NSLayoutConstraint.activate([
            segnify.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segnify.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segnify.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            segnify.heightAnchor.constraint(equalToConstant: 75.0)
            ], for: segnify)
        
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
        NSLayoutConstraint.activate([
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentScrollView.topAnchor.constraint(equalTo: segnify.bottomAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
            ], for: contentScrollView)
        
        // Create a new stack view ...
        let contentStackView = UIStackView()
        contentStackView.alignment = .fill
        contentStackView.axis = .horizontal
        contentStackView.distribution = .equalSpacing
        contentStackView.spacing = 0.0
        // ... add it to the scroll view ...
        contentScrollView.addSubview(contentStackView)
        // ... and give it the correct layout.
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            contentStackView.heightAnchor.constraint(equalTo: contentScrollView.heightAnchor)
            ], for: contentStackView)
        
        // Add some text labels to the stack view.
        for segmentTitle in segmentTitles {
            let textLabel = UILabel()
            textLabel.text = segmentTitle
            textLabel.textAlignment = .center

            // Add it to the view ...
            contentStackView.addArrangedSubview(textLabel)
            // ... and give it the correct layout.
            NSLayoutConstraint.activate([
                textLabel.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor)
                ], for: textLabel)
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
