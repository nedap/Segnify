//
//  SegnifyDataSourceProtocol.swift
//  Segnify
//
//  Created by Bart Hopster on 02/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

/// Define the data model objects for your `Segnify` instance.
public protocol SegnifyDataSourceProtocol {
    
    /// The segments to be shown.
    /// This array shouldn't be empty in order to have a functional `Segnify` instance.
    var segments: [Segment] { get }
}
