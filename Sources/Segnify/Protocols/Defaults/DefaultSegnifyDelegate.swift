//
//  DefaultSegnifyDelegate.swift
//  Segnify
//
//  Created by Bart Hopster on 27/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// Provides a default implementation for `SegnifyProtocol`.
public class DefaultSegnifyDelegate: SegnifyProtocol {

    // MARK: - Delegate
    
    public var backgroundColor: UIColor {
        return .init(red: 76.0/255.0, green: 114.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    }
    
    public var isEquallyFillingHorizontalSpace: Bool {
        return true
    }
    
    public var segmentWidth: CGFloat {
        return 150.0
    }
}
