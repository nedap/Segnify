//
//  DefaultPageViewControllerDelegate.swift
//  Segnify
//
//  Created by Bart Hopster on 27/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

/// Provides a default implementation for `PageViewControllerProtocol`.
public class DefaultPageViewControllerDelegate: PageViewControllerProtocol {
    
    // MARK: - Delegate
    
    public var backgroundColor: UIColor {
        return .black
    }
    
    public var segnifyHeight: CGFloat {
        return 75.0
    }
}
