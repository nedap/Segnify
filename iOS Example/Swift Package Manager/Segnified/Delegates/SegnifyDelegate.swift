//
//  SegnifyDelegate.swift
//  Segnified
//
//  Created by Bart Hopster on 23/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit
import Segnify

/// Implements `SegnifyProtocol`.
public class SegnifyDelegate: SegnifyProtocol {
    
    // MARK: - Delegate
    
    public var backgroundColor: UIColor = .white
    
    public var footerView: UIView {
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
            textLabel.heightAnchor.constraint(equalToConstant: 35.0)
            ], for: textLabel)
        
        return footerView
    }
    
    public var isEquallyFillingHorizontalSpace: Bool {
        // Show all segments at once on iPad.
        return UIDevice.current.userInterfaceIdiom == .pad ? true : false
    }
    
    public var segmentWidth: CGFloat {
        // Show three segments and a bit of the fourth on iPhone.
        // For iPad, this value will be ignored, because of `isEquallyFillingHorizontalSpace`.
        return (UIScreen.main.bounds.width / 3) * 0.80
    }
}
