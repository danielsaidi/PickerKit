//
//  ColorPickerBar.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2023-06-13.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import Foundation

#if os(iOS) || os(macOS) || os(visionOS)
import SwiftUI

public extension ColorPickerBar {

    /// This type can be used to style a ``ColorPickerBar``.
    ///
    /// You can apply this style with ``SwiftUICore/View/colorPickerBarStyle(_:)``.
    struct Style {

        /// Create a custom color picker bar style.
        ///
        /// - Parameters:
        ///   - animation: The animation to apply when picking color, by default `.default`.
        ///   - spacing: The bar item spacing, by default `10`.
        ///   - colorSize: The size of non-selected colors, by default `20`.
        ///   - selectedColorSize: The size of the selected color, by default `30`.
        ///   - resetButton: Whether to add a reset button, by default `false`.
        ///   - resetButtonImage: The image to use as reset button image, by default `circle.slash`.
        public init(
            animation: Animation = .default,
            spacing: Double = 10.0,
            colorSize: Double = 20.0,
            selectedColorSize: Double = 30.0,
            resetButton: Bool = false,
            resetButtonImage: Image = Image(systemName: "xmark.circle")
        ) {
            self.animation = animation
            self.spacing = spacing
            self.colorSize = colorSize
            self.selectedColorSize = selectedColorSize
            self.resetButton = resetButton
            self.resetButtonImage = resetButtonImage
        }

        /// The animation to apply when picking colors.
        public var animation: Animation

        /// The bar item spacing.
        public var spacing: Double

        /// The size of non-selected colors.
        public var colorSize: Double

        /// The size of the selected color.
        public var selectedColorSize: Double

        /// Whether to add a reset button to the picker bar.
        public var resetButton: Bool

        /// The image to use as reset button image
        public var resetButtonImage: Image
    }
}

public extension ColorPickerBar.Style {

    /// A standard color picker bar style.
    static var standard: Self { .init() }
}

public extension View {

    /// Apply a custom ``ColorPickerBar/Style``.
    func colorPickerBarStyle(
        _ style: ColorPickerBar.Style
    ) -> some View {
        self.environment(\.colorPickerBarStyle, style)
    }
}

public extension EnvironmentValues {

    @Entry var colorPickerBarStyle = ColorPickerBar.Style.standard
}
#endif
