//
//  ColorPickerBar+Configuration.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2023-06-13.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import Foundation

#if os(iOS) || os(macOS) || os(visionOS)
import SwiftUI

@available(*, deprecated, message: "Use ColorPickerBar init properties directly instead.")
public extension ColorPickerBar {

    /// This type can be used to configure a ``ColorPickerBar``.
    struct Configuration {

        /// Create a custom color picker bar configuration.
        ///
        /// - Parameters:
        ///   - barColors: The colors to add to the bar, by default `.standardColorPickerBarColors`.
        ///   - resetValue: An optional reset value, by default `nil`.
        ///   - supportsOpacity: Whether to support opacity, by default `true`.
        public init(
            barColors: [Color] = .standardColorPickerBarColors,
            resetValue: Color? = nil,
            supportsOpacity: Bool = true
        ) {
            self.barColors = barColors
            self.resetValue = resetValue
            self.supportsOpacity = supportsOpacity
        }

        /// The colors to list in the bar, by default `.colorPickerBarColors`.
        public let barColors: [Color]

        /// An optional reset value.
        public var resetValue: Color?

        /// Whether the picker supports opacity.
        public var supportsOpacity: Bool

        /// A standard color picker bar configuration.
        public static var standard: Self { .init() }
    }
}

@available(*, deprecated, message: "Use ColorPickerBar init properties directly instead.")
public extension View {

    /// Apply a custom ``ColorPickerBar/Configuration``.
    func colorPickerBarConfiguration(
        _ config: ColorPickerBar.Configuration
    ) -> some View {
        self.environment(\.colorPickerBarConfiguration, config)
    }
}

@available(*, deprecated, message: "Use ColorPickerBar init properties directly instead.")
public extension EnvironmentValues {

    @Entry var colorPickerBarConfiguration = ColorPickerBar.Configuration.standard
}
#endif
