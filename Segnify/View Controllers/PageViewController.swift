//
//  PageViewController.swift
//  Segnify
//
//  Created by Bart Hopster on 29/10/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// The `PageViewController` controls and maintains both `Segnify` and `PageViewController` instances.
open class PageViewController: UIViewController {
    
    // MARK: - Private variables
    
    /// Maintains the height of the `Segnify` instance.
    private var segnifyHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Public variables
    
    /// A `UIPageViewController` instance will shown the main content, below the `Segnify` instance.
    public lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        return pageViewController
    }()
    
    /// A `Segnify` instance will be shown above the `PageViewController` instance, showing all `Segment` instances.
    public lazy var segnify: Segnify = {
        let segnify = Segnify()
        segnify.eventsDelegate = self
        segnify.segnicator = Segnicator(configuration: DefaultDelegates.shared)
        return segnify
    }()
    
    /// The delegate object of `SegnifyDataSourceProtocol` specifies the content for the `Segnify` instance and this `PageViewController` instance.
    public var dataSource: SegnifyDataSourceProtocol? {
        didSet {
            // Populate.
            segnify.dataSource = dataSource
            segnify.populate()
            
            if dataSource?.contentElements.isEmpty == false {
                // Reset the view controllers of the page view controller.
                pageViewController.setViewControllers([dataSource!.contentElements.first!.viewController],
                                                      direction: .forward,
                                                      animated: false)
            }
        }
    }
    
    /// The delegate object of `PageViewControllerProtocol` offers customization possibilities for this `PageViewController` instance.
    public var delegate: PageViewControllerProtocol? {
        didSet {
            if let delegate = delegate {
                // Set the background color.
                view.backgroundColor = delegate.backgroundColor
                
                // Update the height constraint ...
                segnifyHeightConstraint?.constant = delegate.segnifyHeight
                // ... and trigger a layout update.
                view.setNeedsLayout()
            }
        }
    }
    
    // MARK: - Lifecycle
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup(dataSource: SegnifyDataSourceProtocol? = DefaultDelegates.shared,
                       delegate: PageViewControllerProtocol? = DefaultDelegates.shared) {
        self.dataSource = dataSource
        self.delegate = delegate
    }
    
    // MARK: - View lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Adjusting the scroll view insets will result in a weird UI on iOS 10 and earlier.
        automaticallyAdjustsScrollViewInsets = false
        
        // Load up the Segnify instance.
        view.addSubview(segnify)
        
        // Give it some Auto Layout constraints.
        segnifyHeightConstraint = segnify.heightAnchor.constraint(equalToConstant: delegate?.segnifyHeight ?? 0.0)
        NSLayoutConstraint.activate([
            segnify.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segnify.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segnify.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            segnifyHeightConstraint!
            ], for: segnify)
        
        // Add the page view controller.
        if let pageView = pageViewController.view {
            addChild(pageViewController)
            view.addSubview(pageView)
            pageViewController.didMove(toParent: self)
            
            // Give it some Auto Layout constraints.
            NSLayoutConstraint.activate([
                pageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                pageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                pageView.topAnchor.constraint(equalTo: segnify.bottomAnchor),
                pageView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
                ], for: pageView)
        }
    }
}

// MARK: - SegnifyEventsProtocol

extension PageViewController: SegnifyEventsProtocol {
    
    public func didSelect(segment: Segment, of segnify: Segnify, previousIndex: Int?, currentIndex: Int) {
        if previousIndex == nil {
            // `previousIndex` is nil on initial selection. No need to continue in this case.
            return
        }
        
        // We need content elements.
        guard let contentElements = dataSource?.contentElements else {
            return
        }
        
        // Define the navigation direction, depending on the indices.
        let navigationDirection: UIPageViewController.NavigationDirection = (currentIndex > previousIndex!) ? .forward : .reverse
        // Programmatically set the view controllers in order to scroll.
        pageViewController.setViewControllers([contentElements[currentIndex].viewController],
                                              direction: navigationDirection,
                                              animated: true)
    }
}

// MARK: - UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // We need content elements.
        guard let contentElements = dataSource?.contentElements else {
            return nil
        }
        
        // Check if we can get a valid index.
        guard let currentIndex = firstIndexOf(viewController) else {
            return nil
        }
        
        // One stap back.
        let previousIndex = currentIndex - 1
        
        // Sanity check.
        guard previousIndex >= 0 else {
            return nil
        }
        
        return contentElements[previousIndex].viewController
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // We need content elements.
        guard let contentElements = dataSource?.contentElements else {
            return nil
        }
        
        // Check if we can get a valid index.
        guard let currentIndex = firstIndexOf(viewController) else {
            return nil
        }
        
        // One stap forward.
        let nextIndex = currentIndex + 1
        
        // Sanity check.
        guard nextIndex < contentElements.count else {
            return nil
        }
        
        return contentElements[nextIndex].viewController
    }
}

// MARK: - UIPageViewControllerDelegate

extension PageViewController: UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   didFinishAnimating finished: Bool,
                                   previousViewControllers: [UIViewController],
                                   transitionCompleted completed: Bool) {
        // Grab the current view controller.
        guard let currentViewController = pageViewController.viewControllers?.first else {
            return
        }
        
        if let indexOfCurrentViewController = firstIndexOf(currentViewController) {
            // Switch segment.
            segnify.switchSegment(indexOfCurrentViewController)
        }
    }
}

// MARK: - Page view controller helper

extension PageViewController {
    
    private func firstIndexOf(_ viewController: UIViewController) -> Int? {
        // We need content elements.
        guard let contentElements = dataSource?.contentElements else {
            return nil
        }
        
        return contentElements.firstIndex {($0.viewController == viewController)}
    }
}
