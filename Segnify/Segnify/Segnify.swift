//
//  Segnify.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

import SnapKit

/// A `Segnify` instance represents a segmented component, based on UISegmentedControl, and features many customization options
class Segnify: BaseView {

    // MARK: - Private variables
    
    /// The top level scroll view, which makes Segnify horizontally scroll.
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    /// Holds all `Segment` instances.
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        return stackView
    }()
    
    /// Adds a `Segnicator` instance to be able to visually indicate the currently selected `Segment` instance.
    private lazy var segnicator: Segnicator = {
        return Segnicator()
    }()
    
    /// Maintains the horizontal position of the `Segnicator` instance in relation to `scrollView`.
    private var segnicatorLeadingSpaceToSuperviewConstraint: Constraint?
    
    /// The currently selected `Segment` instance.
    private var selectedSegment: Segment?
    
    /// The width of every `Segment` instance. Defaults to 100.0.
    private var segmentWidth: CGFloat = 100.0
    
    // MARK: - View & constraints
    
    override func setupSubviews() {
        // Scroll view.
        addSubview(scrollView)
        
        // Stack view.
        scrollView.addSubview(stackView)
     
        // Segnicator.
        scrollView.addSubview(segnicator)
    }
    
    override func setupAutoLayoutConstraints() {
        // Scroll view.
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Stack view.
        stackView.snp.makeConstraints { make in
            make.edges.size.equalToSuperview()
        }
        
        // Segnicator.
        segnicator.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            // Set the width on 0.0 initially.
            make.width.equalTo(0.0)
            // Save the leading space to its superview. as we'll update it later on.
            segnicatorLeadingSpaceToSuperviewConstraint = make.leading.equalToSuperview().constraint
        }
    }
    
    // MARK: - Populate
    
    public func populate(with segments: [Segment],
                         segnicatorConfiguration: SegnicatorConfiguration?,
                         segnifyConfiguration: SegnifyConfiguration?) {
        // We need a superview.
        guard let superview = superview else {
            return
        }
        
        // The `segnicator` instance is responsible for nil-checking the configuration.
        segnicator.segnicatorConfiguration = segnicatorConfiguration
        
        if let configuration = segnifyConfiguration {
            // Apply the segnify configuration.
            scrollView.alwaysBounceHorizontal = configuration.isBouncingHorizontally ?? true
            backgroundColor = configuration.segnifyBackgroundColor
            
            if configuration.equallyFillHorizontalSpace == true {
                // The segment width should be at least 100.0 (see the default value of `segmentWidth`).
                // In the event of 3 or less segments, the width can be greater than 100.0, so the segments will equally fill the space available.
                // In the event of 4 or more, the segments might not fit on the screen, so stick to the default width of 100.0.
                segmentWidth = max(segmentWidth, superview.bounds.maxX / CGFloat(segments.count))
            }
        }
        
        // Update the segnicator width, when necessary.
        segnicator.snp.updateConstraints { make in
            make.width.equalTo(segmentWidth)
        }
    }
    
    private func populate(with segments: [Segment]) {
        // Clean up first.
        for subview in stackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
        
        for segment in segments {
            // Make the segment clickable by attaching a target to it.
            segment.addTarget(self, action: #selector(didTouchUpInsideSegment(_:)), for: .touchUpInside)
            // Give it the right width.
            segment.snp.makeConstraints { make in
                make.width.equalTo(segmentWidth)
            }
            // Add it to the stack view.
            stackView.addArrangedSubview(segment)
        }
    }
    
    // MARK: - Segment selection
    
    @objc private func didTouchUpInsideSegment(_ segment: Segment) {
        
    }
}
