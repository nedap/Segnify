//
//  PageViewControllerEventsProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 30/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// Can be used for extended usage of the `UIPageViewControllerDataSource` and `UIPageViewControllerDelegate` protocols.
/// `PageViewController` implements specific methods of these protocols, but they can be used for multiple purposes.
/// By implementing this protocol, the original protocol methods can be used without the risk of breaking
/// the current implementions, done by `PageViewController`.
public protocol PageViewControllerEventsProtocol {
    
    // MARK: - UIPageViewControllerDataSource
    
    // In terms of navigation direction. For example, for 'UIPageViewControllerNavigationOrientationHorizontal',
    // view controllers coming 'before' would be to the left of the argument view controller, those coming 'after' would be to the right.
    // For gesture-initiated transitions, the page view controller obtains view controllers via these methods, so use of setViewControllers:direction:animated:completion: is not required.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController)
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController)
    
    // MARK: - UIPageViewControllerDelegate
    
    // Sent when a gesture-initiated transition begins.
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController])
    
    // Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished,
    // while the 'completed' parameter indicates whether the transition completed or bailed out (if the user lets go early).
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool)
}
