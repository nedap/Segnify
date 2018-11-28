//
//  SegnifyError.swift
//  Segnify
//
//  Created by Bart Hopster on 27/11/2018.
//  Copyright © 2018 Bart Hopster. All rights reserved.
//

import UIKit

enum SegnifyError: Error {
    /// Thrown when a nil `SegnifyDataSourceProtocol` is being set.
    case invalidDataSource
}
