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
    
    // MARK: - Public variables
    
    /// A `UIPageViewController` instance will show the main content, below the `Segnify` instance and, optionally, its footer view.
    public lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        return pageViewController
    }()
    
    /// A `Segnify` instance will be shown above the `Segnify` instance and, optionally, its footer view.
    public lazy var segnify: Segnify = {
        let segnify = Segnify()
        segnify.eventsDelegate = self
        segnify.segnicator = Segnicator(configuration: DefaultSegnicatorDelegate())
        return segnify
    }()
    
    // MARK: - Delegates
    
    /// The delegate object of `SegnifyDataSourceProtocol` specifies the content for the `Segnify` instance and this `PageViewController` instance.
    public private(set) weak var dataSource: SegnifyDataSourceProtocol?
    
    /// The delegate object of `PageViewControllerProtocol` offers customization possibilities for this `PageViewController` instance.
    public weak var delegate: PageViewControllerProtocol? {
        didSet {
            if let delegate = delegate {
                // Background color.
                view.backgroundColor = delegate.backgroundColor
                
                // Update the height ...
                segnify.height = delegate.segnifyHeight
                // ... and trigger a layout update.
                view.setNeedsLayout()
            }
        }
    }
    
    /// The delegate object of `ForwardedEventsProtocol` will be notified of various `Segnify` and `UIPageViewController` events.
    public weak var forwardedEventsDelegate: ForwardedEventsProtocol? {
        didSet {
            segnify.forwardedEventsDelegate = forwardedEventsDelegate
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
    
    private func setup(dataSource: SegnifyDataSourceProtocol? = DefaultSegnifyDataSourceDelegate(),
                       delegate: PageViewControllerProtocol? = DefaultPageViewControllerDelegate()) {
        do {
            try setDataSource(dataSource)
            self.delegate = delegate
        }
        catch {
            // Fail.
            print("Failed to set the data source. Make sure it isn't nil.")
        }
    }
    
    /// Sets the data source for the `Segnify` instance and `UIPageViewController` instance.
    public func setDataSource(_ dataSource: SegnifyDataSourceProtocol?) throws {
        if dataSource == nil {
            // Let the user know we're dealing with an invalid data source.
            throw SegnifyError.invalidDataSource
        }
        
        self.dataSource = dataSource
        
        // Populate.
        segnify.dataSource = dataSource
        segnify.populate()
        
        if dataSource!.contentElements.isEmpty == false {
            // Reset the view controllers of the page view controller.
            pageViewController.setViewControllers([dataSource!.contentElements.first!.viewController],
                                                  direction: .forward,
                                                  animated: false)
        }
    }
    
    // MARK: - View lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Adjusting the scroll view insets will result in a weird UI on iOS 10 and earlier.
        automaticallyAdjustsScrollViewInsets = false
        
        // Load up the Segnify instance.
        view.addSubview(segnify)
        
        // Give it some Auto Layout constraints.
        NSLayoutConstraint.activate([
            segnify.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            segnify.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segnify.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ], for: segnify)
        
        // Add the page view controller.
        if let pageView = pageViewController.view {
            addChild(pageViewController)
            view.addSubview(pageView)
            pageViewController.didMove(toParent: self)
            
            // Give it some Auto Layout constraints.
            NSLayoutConstraint.activate([
                pageView.topAnchor.constraint(equalTo: segnify.bottomAnchor),
                pageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                pageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                pageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // We need content elements.
        guard let contentElements = dataSource?.contentElements else {
            return nil
        }
        
        // Check if we can get a valid index.
        guard let currentIndex = firstIndexOf(viewController) else {
            return nil
        }
        
        // One step back.
        let previousIndex = currentIndex - 1
        
        var viewControllerToReturn: UIViewController? = nil
        if previousIndex >= 0 {
            // Just return the previous view controller.
            viewControllerToReturn = contentElements[previousIndex].viewController
        }
        else if segnify.delegate?.isScrollingInfinitely == true {
            // When `previousIndex` becomes negative, the user wants to scroll backwards from the first page.
            // Show the last page.
            viewControllerToReturn = contentElements.last?.viewController
        }
        else {
            // Nothing to return in this case, when `isScrollingInfinitely` is `false`.
        }
        
        // Notify our 'custom' delegate.
        forwardedEventsDelegate?.pageViewController(pageViewController,
                                                    requested: viewControllerToReturn,
                                                    before: viewController)
        
        return viewControllerToReturn
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // We need content elements.
        guard let contentElements = dataSource?.contentElements else {
            return nil
        }
        
        // Check if we can get a valid index.
        guard let currentIndex = firstIndexOf(viewController) else {
            return nil
        }
        
        // One step forward.
        let nextIndex = currentIndex + 1
        
        var viewControllerToReturn: UIViewController? = nil
        if nextIndex < contentElements.count {
            // Just return the next view controller.
            viewControllerToReturn = contentElements[nextIndex].viewController
        }
        else if segnify.delegate?.isScrollingInfinitely == true {
            // When `nextIndex` exceeds the number of available view controllers,
            // the user wants to scroll forwards from the last page.
            // Show the first page.
            viewControllerToReturn = contentElements.first?.viewController
        }
        else {
            // Nothing to return in this case, when `isScrollingInfinitely` is `false`.
        }
        
        // Notify our 'custom' delegate.
        forwardedEventsDelegate?.pageViewController(pageViewController,
                                                    requested: viewControllerToReturn,
                                                    after: viewController)
        
        return viewControllerToReturn
    }
}

// MARK: - UIPageViewControllerDelegate

extension PageViewController: UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   willTransitionTo pendingViewControllers: [UIViewController]) {
        // Notify our 'custom' delegate.
        forwardedEventsDelegate?.pageViewController(pageViewController, willTransitionTo: pendingViewControllers)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   didFinishAnimating finished: Bool,
                                   previousViewControllers: [UIViewController],
                                   transitionCompleted completed: Bool) {
        // Grab the current view controller.
        guard let currentViewController = pageViewController.viewControllers?.first else {
            return
        }
        
        // Notify our 'custom' delegate.
        forwardedEventsDelegate?.pageViewController(pageViewController,
                                                    didFinishAnimating: finished,
                                                    previousViewControllers: previousViewControllers,
                                                    transitionCompleted: completed)
        
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
