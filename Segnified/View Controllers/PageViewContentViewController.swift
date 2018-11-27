//
//  PageViewContentViewController.swift
//  Segnified
//
//  Created by Bart Hopster on 22/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import Segnify

class PageViewContentViewController: UIViewController {
    
    // MARK: - Private variables
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 24.0)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    // MARK: - Lifecycle
    
    convenience init(text: String) {
        self.init()
        
        textLabel.text = text
    }

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Background color.
        view.backgroundColor = .white
        
        // Text label.
        view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)], for: textLabel)
    }
}
