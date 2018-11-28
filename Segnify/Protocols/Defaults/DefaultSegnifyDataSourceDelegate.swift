//
//  DefaultSegnifyDataSourceDelegate.swift
//  Segnify
//
//  Created by Bart Hopster on 27/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

/// Provides a default implementation for `PageViewControllerProtocol`.
public class DefaultSegnifyDataSourceDelegate: SegnifyDataSourceProtocol {
    
    // MARK: - Private
    
    /// Define an instance of `DefaultTextSegmentDelegate`.
    private lazy var textSegmentDelegate: TextSegmentProtocol = {
        return DefaultTextSegmentDelegate()
    }()
    
    /// Generate a new UIViewController instance with a random background color.
    private func generateViewController() -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor(white: .random(in: 0.0 ... 1.0), alpha: 1.0)
        return viewController
    }
    
    // MARK: - Delegate
    
    /// The collection of segment-viewcontroller-tuples, used by the `Segnify` instance.
    private lazy var content: [SegnifyContentElement] = {
        return [(segment: TextSegment(text: "Segment 1", configuration: textSegmentDelegate),
                 viewController: generateViewController()),
                (segment: TextSegment(text: "Segment 2", configuration: textSegmentDelegate),
                 viewController: generateViewController()),
                (segment: TextSegment(text: "Segment 3", configuration: textSegmentDelegate),
                 viewController: generateViewController())]
    }()

    public var contentElements: [SegnifyContentElement] {
        return content
    }
}
