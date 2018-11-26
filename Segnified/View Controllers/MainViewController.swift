//
//  MainViewController.swift
//  Segnified
//
//  Created by Bart Hopster on 26/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import Segnify

public class MainViewController: PageViewController {
    
    // MARK: - Private delegates
    
    private var content = [SegnifyContentElement]()
    
    private lazy var imageSegmentDelegate = ImageSegmentDelegate()
    
    private lazy var pageViewControllerDelegate = PageViewControllerDelegate()
    
    private lazy var segnicatorDelegate = SegnicatorDelegate()
    
    private lazy var segnifyDelegate = SegnifyDelegate()
    
    private lazy var textSegmentDelegate = TextSegmentDelegate()
    
    // MARK: - View lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = pageViewControllerDelegate
        
        segnify.delegate = segnifyDelegate
        segnify.segnicator = Segnicator(configuration: segnicatorDelegate)
    }
}

// MARK: - SegnifyDataSourceProtocol

extension MainViewController: SegnifyDataSourceProtocol {
    
    public var contentElements: [SegnifyContentElement] {
        if content.isEmpty {
            content = [
                (segment: ImageSegment(image: UIImage(named: "demo_number_1_icon"), configuration: imageSegmentDelegate),
                 viewController: LabeledViewController(text: "Hey you! This is number 1.")),
                (segment: TextSegment(text: "Number 2", configuration: textSegmentDelegate),
                 viewController: LabeledViewController(text: "This is number 2 indeed.")),
                (segment: ImageSegment(image: UIImage(named: "demo_number_3_icon"), configuration: imageSegmentDelegate),
                 viewController: LabeledViewController(text: "Ola! Si si, 3 it is.")),
                (segment: TextSegment(text: "Numéro 4", configuration: textSegmentDelegate),
                 viewController: LabeledViewController(text: "Oh man, number 4 already.")),
                (segment: TextSegment(text: "5 💁🏼‍♂️", configuration: textSegmentDelegate),
                 viewController: LabeledViewController(text: "Number 5 is being shown."))
            ]
        }
        
        return content
    }
}
