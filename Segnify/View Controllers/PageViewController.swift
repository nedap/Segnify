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
    
    /// A `UIPageViewController` instance will shown the main content, below the `Segnify` instance.
    private lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = self
        return pageViewController
    }()
    
    /// A `Segnify` instance will be shown above the `PageViewController` instance, showing all `Segment` instances.
    private lazy var segnify: Segnify = {
        let segnify = Segnify()
        segnify.eventsDelegate = self
        return segnify
    }()
    
    /// Maintains the height of the `Segnify` instance.
    private var segnifyHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Delegates
    
    /// The `PageViewControllerDataSourceProtocol` implementing delegate will define the view controllers for the main content.
    public var dataSource: PageViewControllerDataSourceProtocol? {
        didSet {
            if dataSource?.viewControllers.isEmpty == false {
                // Reset the view controllers of the page view controller.
                pageViewController.setViewControllers([dataSource!.viewControllers.first!],
                                                      direction: .forward,
                                                      animated: true)
            }
        }
    }
    
    /// The delegate object of `SegnifiedPageViewControllerProtocol` offers customization possibilities for this `SegnifiedPageViewController`.
    public var delegate: PageViewControllerProtocol? {
        didSet {
            if let delegate = delegate {
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
    
    public func setup(dataSource: PageViewControllerDataSourceProtocol? = DefaultDelegates.shared,
                      delegate: PageViewControllerProtocol? = DefaultDelegates.shared) {
        self.dataSource = dataSource
        self.delegate = delegate
    }
    
    // MARK: - View lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // Populate.
        segnify.populate()
        
        // Add the page view controller.
        addChild(pageViewController)
        let pageView = pageViewController.view
        view.addSubview(pageView!)
        pageViewController.didMove(toParent: self)
        
        // Give it some Auto Layout constraints.
        NSLayoutConstraint.activate([
            pageView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageView!.topAnchor.constraint(equalTo: segnify.bottomAnchor),
            pageView!.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
            ], for: pageView!)
    }
}

extension PageViewController: SegnifyEventsProtocol {
    
    public func didSelect(segment: Segment, of segnify: Segnify, previousIndex: Int?, currentIndex: Int) {
        if previousIndex == nil {
            // `previousIndex` is nil on initial selection. No need to continue in this case.
            return
        }
        
        // We need view controllers.
        guard let viewControllers = dataSource?.viewControllers else {
            return
        }
        
        // Define the navigation direction, depending on the indices.
        let navigationDirection: UIPageViewController.NavigationDirection = (currentIndex > previousIndex!) ? .forward : .reverse
        // Programmatically set the view controllers in order to scroll.
        pageViewController.setViewControllers([viewControllers[currentIndex]],
                                              direction: navigationDirection,
                                              animated: true)
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // We need view controllers.
        guard let viewControllers = dataSource?.viewControllers else {
            return nil
        }
        
        // We can safely assume that the current view controller is in the data source's array.
        let currentIndex = viewControllers.firstIndex(of: viewController)!
        // One stap back.
        let previousIndex = currentIndex - 1
        
        // Sanity check.
        guard previousIndex >= 0 else {
            return nil
        }
        
        return viewControllers[previousIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // We need view controllers.
        guard let viewControllers = dataSource?.viewControllers else {
            return nil
        }
        
        // We can safely assume that the current view controller is in the data source's array.
        let currentIndex = viewControllers.firstIndex(of: viewController)!
        // One stap forward.
        let nextIndex = currentIndex + 1
        
        // Sanity check.
        guard nextIndex < viewControllers.count else {
            return nil
        }
        
        return viewControllers[nextIndex]
    }
}
