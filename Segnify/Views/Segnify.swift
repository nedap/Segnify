//
//  Segnify.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// A `Segnify` instance represents a segmented component, based on UISegmentedControl, and features many customization options.
open class Segnify: UIView {

    // MARK: - Private variables
    
    /// The top level scroll view, which makes Segnify horizontally scroll.
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    /// The width of every `Segment` instance.
    private var segmentWidth: CGFloat = 0.0
    
    /// Maintains the width of all `Segment` instances. All `Segment` instances will have the same width configured, but need their own constraint.
    private var segmentWidthConstraints = [NSLayoutConstraint]()
    
    /// Maintains the horizontal position of the `Segnicator` instance in relation to `scrollView`.
    private var segnicatorLeadingSpaceToSuperviewConstraint: NSLayoutConstraint?
    
    /// Maintains the width of the `Segnicator` instance.
    private var segnicatorWidthConstraint: NSLayoutConstraint?
    
    /// The currently selected `Segment` instance.
    private var selectedSegment: Segment?
    
    /// Holds all `Segment` instances.
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        return stackView
    }()
    
    /// Keeps track of the width constraint of `stackView`, which will be equal to the width of `scrollView`.
    /// It's only there for the benefit of Auto Layout: after adding one or more `Segment` instances, the constraint will be deactivated.
    private var stackViewWidthConstraint: NSLayoutConstraint?
    
    // MARK: - Delegates
    
    /// The `SegnifyDataSourceProtocol` implementing delegate will define the titles for the `Segment` instances of `Segnify`.
    public var dataSource: SegnifyDataSourceProtocol?
    
    /// The `SegnifyProtocol` implementing delegate will configure some properties of the `Segnify` instance.
    public var delegate: SegnifyProtocol? {
        didSet {
            if let delegate = delegate {
                // Apply the segnify configuration.
                backgroundColor = delegate.segnifyBackgroundColor
                scrollView.alwaysBounceHorizontal = delegate.isBouncingHorizontally
                
                if delegate.equallyFillHorizontalSpace {
                    // If the segments should equally fill the horizontal space, we want to observe orientation changes.
                    // The width of every segment and the segnicator instance are calculated based on the total width of the screen.
                    // That width changes when the orientation of the screen changes, so in that case,
                    // the width of the segments and the segnicator should be recalculated.
//                    NotificationCenter.default.addObserver(self,
//                                                           selector: #selector(didChangeOrientation(_:)),
//                                                           name: UIDevice.orientationDidChangeNotification,
//                                                           object: nil)
                }
                else {
                    segmentWidth = delegate.segmentWidth
                }
            }
        }
    }
    
    /// The `SegnifyEventsProtocol` implementing delegate will be notified if a `Segment` instance has been selected.
    public var eventsDelegate: SegnifyEventsProtocol?
    
    // MARK: - Segnicator
    
    /// The `Segnicator` instance, which will always be on top of the currently selected `Segment` instance.
    public var segnicator: Segnicator? {
        didSet {
            if let segnicator = segnicator {
                // Add the segnicator and give it some Auto Layout constraints.
                scrollView.addSubview(segnicator)
                // Save its width and the leading space to its superview. as we'll update it later on.
                segnicatorLeadingSpaceToSuperviewConstraint = segnicator.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
                segnicatorWidthConstraint = segnicator.widthAnchor.constraint(equalToConstant: segmentWidth)
                NSLayoutConstraint.activate([
                    segnicator.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    segnicator.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                    segnicatorLeadingSpaceToSuperviewConstraint!,
                    segnicatorWidthConstraint!
                    ], for: segnicator)
            }
        }
    }
    
    // MARK: - Orientation changes
    
    @objc private func didChangeOrientation(_ notification: Notification) {
        if let superview = superview {
            // Screen orientation has been changed, so recalculate the width of the segments and the segnicator.
            segmentWidth = superview.bounds.maxX / CGFloat(stackView.arrangedSubviews.count)
            
            // Update the constraints for the width of the segments accordingly ...
            for segmentWidthConstraint in segmentWidthConstraints {
                segmentWidthConstraint.constant = segmentWidth
            }
            // ... just like the constraint for the segnicator width ...
            segnicatorWidthConstraint?.constant = segmentWidth
            // ... and the one for the segnicator position.
            let indexOfSegment = stackView.arrangedSubviews.firstIndex(of: selectedSegment!)!
            segnicatorLeadingSpaceToSuperviewConstraint?.constant = CGFloat(indexOfSegment) * segmentWidth
            
            // Trigger a layout update.
            setNeedsLayout()
        }
    }
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        // When this instance will be added to its superview ...
        if let superview = newSuperview, delegate?.equallyFillHorizontalSpace == true, let segments = dataSource?.segments {
            // ... configure the segment width.
            segmentWidth = superview.bounds.maxX / CGFloat(segments.count)
        }
    }
    
    // MARK - Setup
    
    public func setup(dataSource: SegnifyDataSourceProtocol? = DefaultDelegates.shared,
                      delegate: SegnifyProtocol? = DefaultDelegates.shared,
                      eventsDelegate: SegnifyEventsProtocol? = nil) {
        self.dataSource = dataSource
        self.delegate = delegate
        self.eventsDelegate = eventsDelegate
        
        setupSubviews()
        setupAutoLayoutConstraints()
    }
    
    // MARK: - Subviews & constraints
    
    private func setupSubviews() {
        // Scroll view.
        addSubview(scrollView)
        
        // Stack view.
        scrollView.addSubview(stackView)
    }
    
    private func setupAutoLayoutConstraints() {
        // Scroll view.
        if let superview = scrollView.superview {
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: superview.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                scrollView.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
                ], for: scrollView)
        }
        
        // Stack view.
        if let superview = stackView.superview {
            // Set the width of the stack view temporarily to the width of the scroll view to keep Auto Layout happy.
            // After adding one or more Segments, the constraint will be deactivated again.
            stackViewWidthConstraint = stackView.widthAnchor.constraint(equalTo: superview.widthAnchor)
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: superview.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                stackView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                stackView.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
                stackView.heightAnchor.constraint(equalTo: superview.heightAnchor),
                stackViewWidthConstraint!
                ], for: stackView)
        }
    }
}

// MARK: - Populate

extension Segnify {
    
    public func populate() {
        // Make sure we got one or more segments to deal with.
        guard let segments = dataSource?.segments else {
            return
        }
        // Clean up first.
        for subview in stackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
        // Get rid of any existing, obsolete Auto Layout constraint.
        NSLayoutConstraint.deactivate(segmentWidthConstraints)
        segmentWidthConstraints.removeAll()
        
        for segment in segments {
            // Give it the right width.
            let segmentWidthConstraint = segment.widthAnchor.constraint(equalToConstant: segmentWidth)
            segmentWidthConstraints.append(segmentWidthConstraint)
            NSLayoutConstraint.activate([segmentWidthConstraint], for: segment)
            // Make the segment clickable by attaching a target to it.
            segment.addTarget(self, action: #selector(didTouchUpInsideSegment(_:)), for: .touchUpInside)
            // Add it to the stack view.
            stackView.addArrangedSubview(segment)
        }
        
        if stackView.arrangedSubviews.count > 0, let stackViewWidthConstraint = stackViewWidthConstraint {
            // Deactivate the width contraint, which was only temporarily set.
            NSLayoutConstraint.deactivate([stackViewWidthConstraint])
            self.stackViewWidthConstraint = nil
        }
        
        // Select the first button initially.
        if let firstSegment = stackView.arrangedSubviews.first as? Segment {
            select(firstSegment)
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
            performScrollViewAnimations()
            performSegnicatorAnimations()
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
        var previousIndex: Int?
        var currentIndex: Int
        
        // Grab the currently selected segment, which will be the previously selected one
        // after `handleSegmentSelection` is being called.
        // Will be `nil` at initial selection.
        if let previouslySelectedSegment = selectedSegment {
            previousIndex = stackView.arrangedSubviews.firstIndex(of: previouslySelectedSegment)!
        }
        
        // The segment wants to be selected.
        handleSegmentSelection(with: segment)

        // Set the current index.
        currentIndex = stackView.arrangedSubviews.firstIndex(of: selectedSegment!)!
        
        // Notify the events delegate.
        eventsDelegate?.didSelect(segment: selectedSegment!,
                                  of: self,
                                  previousIndex: previousIndex,
                                  currentIndex: currentIndex)
    }
}

// MARK: - Animations

extension Segnify {
    
    private func performScrollViewAnimations() {
        guard let superview = superview, let selectedSegment = selectedSegment else {
            // We need a superview and a currently selected segment.
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
    
    private func performSegnicatorAnimations() {
        if segnicator?.configuration?.isUpdatingOffsetAtScrolling ?? false {
            // When `isUpdatingOffsetAtScrolling` is set to `true`, the segnicator will animate at scrolling events of the content scroll view.
            return
        }
        
        guard let selectedSegment = selectedSegment else {
            // We need a currently selected segment.
            return
        }
        
        // Process any pending layout updates.
        layoutIfNeeded()
        
        // Update the constraint.
        segnicatorLeadingSpaceToSuperviewConstraint?.constant = selectedSegment.frame.minX
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
            self.layoutIfNeeded()
        })
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
