//
//  Segnify.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// The method of the `SegnifyDelegate` protocol allows the delegate to react on selecting other `Segment` components.
public protocol SegnifyDelegate {
    func segnify(_ segnify: Segnify, didSelect segment: Segment, with index: Int)
}

/// A `Segnify` instance represents a segmented component, based on UISegmentedControl, and features many customization options.
open class Segnify: BaseView, UIScrollViewDelegate {

    // MARK: - Private variables
    
    /// The top level scroll view, which makes Segnify horizontally scroll.
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    /// Holds all `Segment` instances.
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// Keeps track of the width constraint of `stackView`, which will be equal to the width of `scrollView`.
    /// It's only there for the benefit of Auto Layout: after adding one or more `Segment` instances, the constraint will be deactivated.
    private var stackViewWidthConstraint: NSLayoutConstraint?
    
    /// The `Segnicator` instance, which will always be on top of the currently selected `Segment` instance.
    private var segnicator: Segnicator?
    
    /// Maintains the horizontal position of the `Segnicator` instance in relation to `scrollView`.
    private var segnicatorLeadingSpaceToSuperviewConstraint: NSLayoutConstraint?
    
    /// The width of every `Segment` instance.
    private var segmentWidth: CGFloat = 150.0
    
    /// The currently selected `Segment` instance.
    private var selectedSegment: Segment?
    
    // MARK: - Public variables
    
    /// The delegate object of the `SegnifyDelegate` protocol will be notified about changing the currently selected `Segment` instance.
    public var delegate: SegnifyDelegate?
    
    /// The scroll view which works together with, and mostly underneath, the `Segnify` instance.
    ///
    /// Selecting a `Segment` instance will likely result in a scrolling `contentScrollView`, to show the corresponding content.
    /// Scrolling the `contentScrollView` will likely result in animating the `Segnicator` instance, selecting another `Segment` instance, or both.
    public var contentScrollView: UIScrollView? {
        didSet {
            contentScrollView?.delegate = self
        }
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
        if let superview = scrollView.superview {
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: superview.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                scrollView.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ])
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
            ])
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
            if let maximumSegmentWidth = configuration.maximumSegmentWidth {
                segmentWidth = maximumSegmentWidth
            }
            
            if configuration.equallyFillHorizontalSpace == true {
                // In the event of segments overflowing the space available, the width, set by `maximumSegmentWidth`, will reduce, so the segments will equally fill the space available.
                // In the event of segments underflowing the space available, the width sticks to the value of `maximumSegmentWidth`, so the segments will equally fill the space available.
                segmentWidth = min(segmentWidth, superview.bounds.maxX / CGFloat(segments.count))
            }
        }
        
        if let segnicator = segnicator {
            self.segnicator = segnicator
            
            // Add the segnicator and give it some Auto Layout constraints.
            scrollView.addSubview(segnicator)
            // Save the leading space to its superview. as we'll update it later on.
            segnicator.translatesAutoresizingMaskIntoConstraints = false
            segnicatorLeadingSpaceToSuperviewConstraint = segnicator.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
            NSLayoutConstraint.activate([
                segnicator.topAnchor.constraint(equalTo: scrollView.topAnchor),
                segnicator.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                segnicator.widthAnchor.constraint(equalToConstant: segmentWidth),
                segnicatorLeadingSpaceToSuperviewConstraint!
            ])
        }
        
        // Populate.
        populate(with: segments)
        
        // Select the first button initially.8
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
            // Give it the right width.
            segment.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                segment.widthAnchor.constraint(equalToConstant: segmentWidth)
            ])
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
        // The segment wants to be selected.
        handleSegmentSelection(with: segment)

        // Notify the delegate.
        delegate?.segnify(self, didSelect: selectedSegment!, with: stackView.arrangedSubviews.firstIndex(of: selectedSegment!)!)
    }
}

// MARK: - Scroll view delegate

extension Segnify {
    
    /// Updates the horizontal offset of the `Segnicator` instance in relation to the `Segnify` instance.
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if segnicator?.configuration?.isUpdatingOffsetAtScrolling ?? false {
            // Only automatically update the segnicator offset when configured so.
            segnicatorLeadingSpaceToSuperviewConstraint?.constant = scrollView.contentOffset.x * (segmentWidth / frame.width)
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Another segment might have to be selected.
        selectSegment()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            // Another segment might have to be selected.
            selectSegment()
        }
    }
    
    private func selectSegment() {
        // Get the current 'page' of the scroll view ...
        let currentPage = max(0, Int(floor(contentScrollView!.contentOffset.x / frame.width)))
        // ... grab the corresponding segment ...
        let segment = stackView.arrangedSubviews[currentPage] as! Segment
        // ... and select that one.
        handleSegmentSelection(with: segment)
        
        // Animate.
        performScrollViewAnimations()
        performSegnicatorAnimations()
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
