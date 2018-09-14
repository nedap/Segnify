//
//  BaseView.swift
//  Segnify
//
//  Created by Bart Hopster on 14/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// A base class for subclasses of `UIView`, which offers helper methods for adding subviews and adding Auto Layout constraints to them.
class BaseView: UIView {

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupAutoLayoutConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupSubviews()
        setupAutoLayoutConstraints()
    }
    
    // MARK: View & constraints
    
    public func setupSubviews() {
        // Override point.
    }
    
    public func setupAutoLayoutConstraints() {
        // Override point.
    }
}
