//
//  OptionalBinding.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2023-06-15.
//  Copyright © 2023-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This type can wrap any optional value and let it be used
/// together with a non-optional binding.
///
/// To pass in an optional value to a non-optional parameter,
/// just define a fallback value:
///
/// ```swift
/// @State var myValue: Double?
///
/// func doSomething(with binding: Binding<Double>) { ... }
///
/// doSomething(with: $myValue ?? 0)
/// ```
@MainActor
public func OptionalBinding<T>(
    _ binding: Binding<T?>,
    _ defaultValue: T
) -> Binding<T> {
    Binding<T>(get: {
        binding.wrappedValue ?? defaultValue
    }, set: {
        binding.wrappedValue = $0
    })
}

@MainActor
public func ??<T> (left: Binding<T?>, right: T) -> Binding<T> {
    OptionalBinding(left, right)
}
