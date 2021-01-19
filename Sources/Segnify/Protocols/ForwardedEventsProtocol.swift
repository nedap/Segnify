//
//  ForwardedEventsProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 30/11/2018.
//  Copyright © 2021 Bart Hopster. All rights reserved.
//

import UIKit

/// This protocol provides the ability to be informed about several events,
/// caused by either the `Segnify` instance or the `UIPageViewController` instance:
///
/// - Getting the view controller before the currently displayed one
/// - Getting the view controller after the currently displayed one
/// - Gesture-initiated transition triggers
/// - Segment selection trigger
///
/// The protocol partly relies on the `UIPageViewControllerDataSource` and `UIPageViewControllerDelegate` protocols.
/// In this way, the implementations in `PageViewController` aren't at risk.
public protocol ForwardedEventsProtocol: class {
    
    /// Based on the corresponding `UIPageViewControllerDataSource` protocol, this method returns both the view controller
    /// before the currently viewed view controller, where the user navigated away from, and the latter view controller.
    func pageViewController(_ pageViewController: UIPageViewController,
                            requested viewController: UIViewController?,
                            before previousViewController: UIViewController)
    
    /// Based on the corresponding `UIPageViewControllerDataSource` protocol, this method returns both the view controller
    /// after the currently viewed view controller, where the user navigated away from, and the latter view controller.
    func pageViewController(_ pageViewController: UIPageViewController,
                            requested viewController: UIViewController?,
                            after previousViewController: UIViewController)
    
    /// Sent when a gesture-initiated transition begins. Identical to the `UIPageViewControllerDataSource` protocol method.
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController])
    
    /// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished,
    /// while the 'completed' parameter indicates whether the transition completed or bailed out (if the user lets go early).
    /// Identical to the `UIPageViewControllerDataSource` protocol method.
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool)
    
    /// Sent when the user tapped on a non-selected `Segment` instance of the `Segnify` instance.
    /// This method will not be called when the another `Segment` instance is being selected due to a swipe in
    /// the `UIPageViewController` instance.
    func segnify(_ segnify: Segnify, receivedTouchInside segment: Segment)
}

// MARK: - Defaults

extension ForwardedEventsProtocol {
    
    /// Provide a default implementation.
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   requested viewController: UIViewController?,
                                   before previousViewController: UIViewController) {}
    
    /// Provide a default implementation.
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   requested viewController: UIViewController?,
                                   after previousViewController: UIViewController) {}
    
    /// Provide a default implementation.
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   willTransitionTo pendingViewControllers: [UIViewController]) {}
    
    /// Provide a default implementation.
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   didFinishAnimating finished: Bool,
                                   previousViewControllers: [UIViewController],
                                   transitionCompleted completed: Bool) {}
    
    /// Provide a default implementation.
    public func segnify(_ segnify: Segnify, receivedTouchInside segment: Segment) {}
}
