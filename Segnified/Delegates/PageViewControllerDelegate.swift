//
//  PageViewControllerDelegate.swift
//  Segnified
//
//  Created by Bart Hopster on 23/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import Segnify

/// Implements `PageViewControllerProtocol`.
struct PageViewControllerDelegate: PageViewControllerProtocol {
    
    // MARK: - Delegate
    
    var backgroundColor: UIColor = .white
    
    var footerView: UIView {
        // Create a footer view ...
        let footerView = UIView()
        footerView.backgroundColor = .lightGray
        
        // ... with a text label.
        let textLabel = UILabel()
        textLabel.text = "Gorgeous banner view!"
        textLabel.textAlignment = .center
        
        // Add them as subviews and add Auto Layout constraints.
        footerView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: footerView.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor),
            textLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
            ], for: textLabel)
        
        return footerView
    }
    
    var footerViewHeight: CGFloat = 44.0
    
    var segnifyHeight: CGFloat = 100.0
}
