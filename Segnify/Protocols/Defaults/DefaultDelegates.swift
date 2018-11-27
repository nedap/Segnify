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
    
    /// The collection of segment-viewcontroller-tuples, used by the `Segnify` instance.
    private var content = [SegnifyContentElement]()
}

// MARK: - ImageSegmentProtocol

extension DefaultDelegates: ImageSegmentProtocol {
    
    public func isAdjustingImage(for state: UIControl.State) -> Bool {
        return false
    }
    
    public var imageViewEdgeInsets: UIEdgeInsets? {
        return nil
    }
    
    public func segmentBackgroundColor(for state: UIControl.State) -> UIColor {
        switch state {
        case .highlighted, .selected,  [.selected, .highlighted]:
            return .init(red: 39.0/255.0, green: 59.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        default:
            return .clear
        }
    }
}

// MARK: - PageViewControllerProtocol

extension DefaultDelegates: PageViewControllerProtocol {
    
    public var backgroundColor: UIColor {
        return .black
    }
    
    public var segnifyHeight: CGFloat {
        return 75.0
    }
}

// MARK: - SegnicatorProtocol

extension DefaultDelegates: SegnicatorProtocol {
    
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

// MARK: - SegnifyDataSourceProtocol

extension DefaultDelegates: SegnifyDataSourceProtocol {
    
    public var contentElements: [SegnifyContentElement] {
        if content.isEmpty {
            // Fill the collection of content tuples.
            content = [(segment: TextSegment(text: "Segment 1", configuration: self), viewController: generateViewController()),
                       (segment: TextSegment(text: "Segment 2", configuration: self), viewController: generateViewController()),
                       (segment: TextSegment(text: "Segment 3", configuration: self), viewController: generateViewController())]
        }
        
        return content
    }
}

// MARK: - SegnifyProtocol

extension DefaultDelegates: SegnifyProtocol {
    
    public var isEquallyFillingHorizontalSpace: Bool {
        return true
    }
    
    public var isBouncingHorizontally: Bool {
        return true
    }
    
    public var isScrollingInfinitely: Bool {
        return false
    }
    
    public var segmentWidth: CGFloat {
        return 150.0
    }
    
    public var segnifyBackgroundColor: UIColor {
        return .init(red: 76.0/255.0, green: 114.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    }
}

// MARK: - TextSegmentProtocol

extension DefaultDelegates: TextSegmentProtocol {
    
    public var font: UIFont {
        return .systemFont(ofSize: 17.0)
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
