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
    
    /// Maintains the height of the `bannerView`.
    private var bannerViewHeightConstraint: NSLayoutConstraint?
    
    /// Maintains the height of the `Segnify` instance.
    private var segnifyHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Public variables
    
    /// The `bannerView`, which is just a `UIView` instance, will be shown in between
    /// the `Segnify` instance and the `PageViewController` instance.
    public private(set) var bannerView: UIView = {
        let bannerView = UIView()
        bannerView.backgroundColor = .clear
        return bannerView
    }()
    
    /// A `UIPageViewController` instance will show the main content, below the `bannerView`.
    public lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        return pageViewController
    }()
    
    /// A `Segnify` instance will be shown above the `bannerView`, showing all `Segment` instances.
    public lazy var segnify: Segnify = {
        let segnify = Segnify()
        segnify.segnicator = Segnicator(configuration: DefaultSegnicatorDelegate())
        segnify.segnifyEventsDelegate = self
        return segnify
    }()
    
    // MARK: - Delegates
    
    /// The delegate object of `SegnifyDataSourceProtocol` specifies the content for the `Segnify` instance and this `PageViewController` instance.
    public private(set) var dataSource: SegnifyDataSourceProtocol?
    
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
    
    /// The delegate object of `EventsProtocol` will be notified of various `Segnify` and `UIPageViewController` events.
    public var eventsDelegate: EventsProtocol? {
        didSet {
            segnify.eventsDelegate = eventsDelegate
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
        segnifyHeightConstraint = segnify.heightAnchor.constraint(equalToConstant: delegate?.segnifyHeight ?? 0.0)
        NSLayoutConstraint.activate([
            segnify.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segnify.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segnify.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            segnifyHeightConstraint!
            ], for: segnify)
        
        // Load up the banner view.
        view.addSubview(bannerView)
        
        // Give it some Auto Layout constraints.
        bannerViewHeightConstraint = bannerView.heightAnchor.constraint(equalToConstant: delegate?.bannerViewHeight ?? 0.0)
        NSLayoutConstraint.activate([
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView.topAnchor.constraint(equalTo: segnify.bottomAnchor),
            bannerViewHeightConstraint!
            ], for: bannerView)
        
        // Add the page view controller.
        if let pageView = pageViewController.view {
            addChild(pageViewController)
            view.addSubview(pageView)
            pageViewController.didMove(toParent: self)
            
            // Give it some Auto Layout constraints.
            NSLayoutConstraint.activate([
                pageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                pageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                pageView.topAnchor.constraint(equalTo: bannerView.bottomAnchor),
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
            viewControllerToReturn = contentElements.last!.viewController
        }
        else {
            // Nothing to return in this case, when `isScrollingInfinitely` is `false`.
        }
        
        // Notify our 'custom' delegate.
        eventsDelegate?.pageViewController(pageViewController,
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
            viewControllerToReturn = contentElements.first!.viewController
        }
        else {
            // Nothing to return in this case, when `isScrollingInfinitely` is `false`.
        }
        
        // Notify our 'custom' delegate.
        eventsDelegate?.pageViewController(pageViewController,
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
        eventsDelegate?.pageViewController(pageViewController, willTransitionTo: pendingViewControllers)
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
        eventsDelegate?.pageViewController(pageViewController,
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
