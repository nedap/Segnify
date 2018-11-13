//
//  DefaultDelegates.swift
//  Segnify
//
//  Created by Bart Hopster on 30/10/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// Provides default implementations for the several `Segnify` related protocols.
public class DefaultDelegates {
    
    // MARK: - Public
    
    /// Shared instance for singleton usage.
    public static let shared = DefaultDelegates()
    
    // MARK: - Private
    
    /// Generate a new UIViewController instance with a random background color.
    private func generateViewController() -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor(white: .random(in: 0.0 ... 1.0), alpha: 1.0)
        return viewController
    }
    
    /// The collection of segments, used by the `Segnify` instance.
    /// By keeping track of those, continuously generating new ones is being prevented.
    private var randomSegments = [Segment]()
    
    /// The collection of view controllers, used by the page view controller.
    /// By keeping track of those, continuously generating new ones is being prevented.
    private var randomViewControllers = [UIViewController]()
}

// MARK: - ImageSegmentProtocol

extension DefaultDelegates: ImageSegmentProtocol {
    
    public func adjustsImage(for state: UIControl.State) -> Bool {
        return false
    }
    
    public func segmentBackgroundColor(for state: UIControl.State) -> UIColor {
        switch state {
        case .highlighted, .selected,  [.selected, .highlighted]:
            return UIColor(red: 39.0/255.0, green: 59.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        default:
            return .clear
        }
    }
}

// MARK: - SegnicatorProtocol

extension DefaultDelegates: SegnicatorProtocol {
    
    public var isUpdatingOffsetAtScrolling: Bool {
        return true
    }
    
    public var segnicatorSubviewsClosure: SegnicatorSubviewsClosure? {
        return { segnicator in
            // Create a white, horizontal indicator view.
            let whiteIndicatorView = UIView()
            whiteIndicatorView.backgroundColor = .white
            
            // Add it to the segnicator and give it the correct layout.
            segnicator.addSubview(whiteIndicatorView)
            NSLayoutConstraint.activate([
                whiteIndicatorView.leadingAnchor.constraint(equalTo: segnicator.leadingAnchor),
                whiteIndicatorView.trailingAnchor.constraint(equalTo: segnicator.trailingAnchor),
                whiteIndicatorView.bottomAnchor.constraint(equalTo: segnicator.bottomAnchor),
                whiteIndicatorView.heightAnchor.constraint(equalToConstant: 2.0)
                ], for: whiteIndicatorView)
        }
    }
}

// MARK: - PageViewControllerDataSourceProtocol

extension DefaultDelegates: PageViewControllerDataSourceProtocol {
    
    public var viewControllers: [UIViewController] {
        if randomViewControllers.isEmpty {
            // Fill the collection of random view controllers.
            randomViewControllers = [generateViewController(),
                                     generateViewController(),
                                     generateViewController()]
        }
        
        return randomViewControllers
    }
}


// MARK: - SegnifiedPageViewControllerProtocol

extension DefaultDelegates: PageViewControllerProtocol {
    
    public var segnifyHeight: CGFloat {
        return 75.0
    }
}

// MARK: - SegnifyDataSourceProtocol

extension DefaultDelegates: SegnifyDataSourceProtocol {
    
    public var segments: [Segment] {
        if randomSegments.isEmpty {
            // Fill the collection of segments.
            randomSegments = [TextSegment(with: "Segment 1", configuration: self),
                              TextSegment(with: "Segment 2", configuration: self),
                              TextSegment(with: "Segment 3", configuration: self)]
        }
        
        return randomSegments
    }
}

// MARK: - SegnifyProtocol

extension DefaultDelegates: SegnifyProtocol {
    
    public var equallyFillHorizontalSpace: Bool {
        return true
    }
    
    public var isBouncingHorizontally: Bool {
        return true
    }
    
    public var segmentWidth: CGFloat {
        return 150.0
    }
    
    public var segnifyBackgroundColor: UIColor {
        return UIColor(red: 76.0/255.0, green: 114.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    }
}

// MARK: - TextSegmentProtocol

extension DefaultDelegates: TextSegmentProtocol {
    
    public var font: UIFont {
        return UIFont.systemFont(ofSize: 17.0)
    }
    
    public func textColor(for state: UIControl.State) -> UIColor {
        switch state {
        case .highlighted, .selected:
            return .lightGray
        default:
            return .white
        }
    }
}