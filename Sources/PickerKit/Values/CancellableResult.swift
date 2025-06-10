//
//  CancellableResult.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2020-04-07.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This enum represents a cancellable picker result value.
public enum CancellableResult<Value, Error> {

    /// The operation was cancelled.
    case cancelled

    /// The operation failed.
    case failure(Error)

    /// The operation succeeded.
    case success(Value)
}
