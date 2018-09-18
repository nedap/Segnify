//
//  Segnify.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

import SnapKit

public protocol SegnifyDelegate {
    func segnify(_ segnify: Segnify, didSelectSegment: Segment)
}

/// A `Segnify` instance represents a segmented component, based on UISegmentedControl, and features many customization options
open class Segnify: BaseView {

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
    
    /// Maintains the horizontal position of the `Segnicator` instance in relation to `scrollView`.
    private var segnicatorLeadingSpaceToSuperviewConstraint: Constraint?
    
    /// The currently selected `Segment` instance.
    private var selectedSegment: Segment?
    
    /// The width of every `Segment` instance.
    private var segmentWidth: CGFloat = 100.0
    
    // MARK: - Public variables
    
    public var delegate: SegnifyDelegate?
    
    // MARK: - Lifecycle
    
    public convenience init(with segments: [Segment],
                            segnicator: Segnicator?,
                            segnifyConfiguration: SegnifyConfiguration?) {
        self.init(frame: .zero)
        populate(with: segments,
                 segnicator: segnicator,
                 segnifyConfiguration: segnifyConfiguration)
    }
    
    // MARK: - View & constraints
    
    override public func setupSubviews() {
        // Scroll view.
        addSubview(scrollView)
        
        // Stack view.
        scrollView.addSubview(stackView)
    }
    
    override public func setupAutoLayoutConstraints() {
        // Scroll view.
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Stack view.
        stackView.snp.makeConstraints { make in
            make.edges.size.equalToSuperview()
        }
    }
}

// MARK: - Populate

extension Segnify {

    public func populate(with segments: [Segment],
                         segnicator: Segnicator?,
                         segnifyConfiguration: SegnifyConfiguration?) {
        // We need a superview.
        guard let superview = superview else {
            return
        }
        
        if let configuration = segnifyConfiguration {
            // Apply the segnify configuration.
            backgroundColor = configuration.segnifyBackgroundColor
            scrollView.alwaysBounceHorizontal = configuration.isBouncingHorizontally ?? true
            if let minimumSegmentWidth = configuration.minimumSegmentWidth {
                segmentWidth = minimumSegmentWidth
            }
            
            if configuration.equallyFillHorizontalSpace == true {
                // In the event of segments underflowing the space available, the width will increase so the segments will equally fill the space available.
                // In the event of segments overflowing the space available, stick to the minimum width.
                segmentWidth = max(segmentWidth, superview.bounds.maxX / CGFloat(segments.count))
            }
        }
        
        if let segnicator = segnicator {
            // Add the segnicator and give it some Auto Layout constraints.
            scrollView.addSubview(segnicator)
            segnicator.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(segmentWidth)
                // Save the leading space to its superview. as we'll update it later on.
                segnicatorLeadingSpaceToSuperviewConstraint = make.leading.equalToSuperview().constraint
            }
        }
        
        // Populate.
        populate(with: segments)
        
        // Select the first button initially.
        if let firstSegment = stackView.arrangedSubviews.first as? Segment {
            select(firstSegment)
        }
        
        // Scroll to the beginning.
        scrollView.contentOffset = .zero
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
}

// MARK: - Segment selection

extension Segnify {
    
    @objc private func didTouchUpInsideSegment(_ segment: Segment) {
        // Selecting the already selected segment shouldn't have any effect.
        if segment != selectedSegment {
            // Process any pending layout updates.
            layoutIfNeeded()
            
            // Select the actual segment.
            select(segment)
            
            // Animate.
            performAnimations()
        }
    }
    
    private func handleSegmentSelection(with segment: Segment) {
        if let selectedSegment = selectedSegment {
            // Deselect the previously selected segment.
            selectedSegment.isSelected = false
        }
        
        // Set the new selected segment and make it actually selected.
        selectedSegment = segment
        selectedSegment!.isSelected = true
    }
    
    private func select(_ segment: Segment) {
        // The segment wants to be selected.
        handleSegmentSelection(with: segment)

        // Notify the delegate.
        delegate?.segnify(self, didSelectSegment: selectedSegment!)
    }
}

// MARK: - Scroll view animation

extension Segnify {
    
    private func performAnimations() {
        // We need a superview and a currently selected segment.
        guard let superview = superview, let selectedSegment = selectedSegment else {
            return
        }
        
        let amountOfSegments = stackView.arrangedSubviews.count
        if (superview.bounds.maxX / CGFloat(amountOfSegments)) < segmentWidth {
            // The segments overflow the horizontal space available.
            // Make sure the scroll view scrolls according to the currently selected segment.
            
            // Grab the index of the selected segment in the stack view.
            let indexOfSelectedSegmentInStackView = stackView.arrangedSubviews.index(of: selectedSegment)!
            let segmentHeight = selectedSegment.frame.height
            
            switch indexOfSelectedSegmentInStackView {
            case 0:
                // First segment: this segment and the next one should be visible.
                if let nextSegment = getNextSegmentInStackViewWith(currentIndex: indexOfSelectedSegmentInStackView) {
                    scrollView.scrollRectToVisible(CGRect(x: selectedSegment.frame.minX,
                                                          y: 0.0,
                                                          width: nextSegment.frame.maxX,
                                                          height: segmentHeight),
                                                   animated: true)
                }
            case (amountOfSegments - 1):
                // Last segment: this segment and the previous one should be visible.
                if let previousSegment = getPreviousSegmentInStackViewWith(currentIndex: indexOfSelectedSegmentInStackView) {
                    scrollView.scrollRectToVisible(CGRect(x: previousSegment.frame.minX,
                                                          y: 0.0,
                                                          width: selectedSegment.frame.maxX,
                                                          height: segmentHeight),
                                                   animated: true)
                }
            default:
                if (amountOfSegments % 2 != 0 && indexOfSelectedSegmentInStackView == (amountOfSegments - 1) / 2) {
                    // There's an odd amount of segments in the stack view, and the currently selected segment is in the middle, so center the scroll view horizontally.
                    scrollView.setContentOffset(CGPoint(x: stackView.frame.midX - scrollView.frame.midX, y: 0.0), animated: true)
                }
                else {
                    // The currently selected segment is somewhere in the middle, so this segment, the previous one and the next one should be visible.
                    if let previousSegment = getPreviousSegmentInStackViewWith(currentIndex: indexOfSelectedSegmentInStackView),
                        let nextSegment = getNextSegmentInStackViewWith(currentIndex: indexOfSelectedSegmentInStackView) {
                        scrollView.scrollRectToVisible(CGRect(x: previousSegment.frame.minX,
                                                              y: 0.0,
                                                              width: nextSegment.frame.maxX,
                                                              height: segmentHeight),
                                                       animated: true)
                    }
                }
            }
        }
    }
}

// MARK: Segment helpers

extension Segnify {
    
    private func getNextSegmentInStackViewWith(currentIndex: Int) -> Segment? {
        // Check if we're dealing with valid indices.
        let nextIndex = currentIndex + 1
        if nextIndex < stackView.arrangedSubviews.count {
            return stackView.arrangedSubviews[nextIndex] as? Segment
        }
        
        return nil
    }
    
    private func getPreviousSegmentInStackViewWith(currentIndex: Int) -> Segment? {
        // Check if we're dealing with valid indices.
        let previousIndex = currentIndex - 1
        if previousIndex >= 0 {
            return stackView.arrangedSubviews[previousIndex] as? Segment
        }
        
        return nil
    }
}
