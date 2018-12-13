//
//  SegnicatorProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 11/09/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// Customize the `Segnicator` appearance by implementing this protocol.
public protocol SegnicatorProtocol {
    
    /// Specifies the appearance of the `Segnicator` instance.
    var segnicatorView: UIView { get }
}

// MARK: - Defaults

extension SegnicatorProtocol {
    
    /// Provide a default value.
    public var segnicatorView: UIView {
        return UIView()
    }
}
