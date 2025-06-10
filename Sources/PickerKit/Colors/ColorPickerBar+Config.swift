//
//  ColorPickerBar.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2023-06-13.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import Foundation

#if os(iOS) || os(macOS)
import SwiftUI

public extension ColorPickerBar {

    /// This type can be used to config a ``ColorPickerBar``.
    struct Config {

        /// Create a color picker bar configuration.
        ///
        /// - Parameters:
        ///   - barColors: The colors to list in the bar, by default `.colorPickerBarColors`.
        ///   - opacity: Whether to show opacity, by default `true`.
        ///   - resetButton: Whether to add a reset button, by default `false`.
        ///   - resetValue: The color to apply when resetting.
        public init(
            barColors: [Color] = .colorPickerBarColors,
            opacity: Bool = true,
            resetButton: Bool = false,
            resetValue: Color? = nil
        ) {
            self.barColors = barColors
            self.opacity = opacity
            self.resetButton = resetButton
            self.resetValue = resetValue
        }

        /// The colors to list in the bar, by default `.colorPickerBarColors`.
        public let barColors: [Color]

        /// Whether to show opacity.
        public var opacity: Bool

        /// Whether to add a reset button.
        public var resetButton: Bool

        /// The color to apply when resetting.
        public var resetValue: Color?
    }
}

public extension ColorPickerBar.Config {

    /// The standard color picker bar configuration.
    static var standard: Self { .init() }
}

public extension View {

    /// Apply a ``ColorPickerBar/Config`` style to the view.
    func colorPickerBarConfig(
        _ config: ColorPickerBar.Config
    ) -> some View {
        self.environment(\.colorPickerBarConfig, config)
    }
}

private extension ColorPickerBar.Config {

    struct Key: EnvironmentKey {

        public static var defaultValue: ColorPickerBar.Config {
            .standard
        }
    }
}

public extension EnvironmentValues {

    var colorPickerBarConfig: ColorPickerBar.Config {
        get { self [ColorPickerBar.Config.Key.self] }
        set { self [ColorPickerBar.Config.Key.self] = newValue }
    }
}
#endif
