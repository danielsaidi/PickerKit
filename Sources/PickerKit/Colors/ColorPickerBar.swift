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

/// This color picker will present a SwiftUI color picker in
/// a horizontal or vertical bar with additional colors.
///
/// The picker supports both optional and non-optional color
/// values and can customize which colors to show in the bar.
///
/// You can configure and style the color picker by applying
/// the ``SwiftUICore/View/colorPickerBarConfig(_:)`` and
/// ``SwiftUICore/View/colorPickerBarStyle(_:)`` view modifiers
public struct ColorPickerBar: View {

    /// Create a color picker bar with an optional binding.
    ///
    /// - Parameters:
    ///   - title: The picker title, by default "Pick Color".
    ///   - titleBundle: The picker title localization bundle, by default `.main`.
    ///   - value: An optional color value binding.
    public init(
        _ title: String.LocalizationValue = "Pick Color",
        titleBundle: Bundle = .main,
        value: Binding<Color?>
    ) {
        self.title = title
        self.titleBundle = titleBundle
        self.value = value
    }

    /// Create a color picker bar with a non-optional binding.
    ///
    /// - Parameters:
    ///   - title: The picker title, by default "Pick Color".
    ///   - titleBundle: The picker title localization bundle, by default `.main`.
    ///   - value: An non-optional color value binding.
    public init(
        _ title: String.LocalizationValue,
        titleBundle: Bundle = .main,
        value: Binding<Color>
    ) {
        self.title = title
        self.titleBundle = titleBundle
        self.value = .init(get: {
            value.wrappedValue
        }, set: {
            value.wrappedValue = $0 ?? .clear
        })
    }

    private let title: String.LocalizationValue
    private let titleBundle: Bundle
    private let value: Binding<Color?>
    
    @Environment(\.colorPickerBarConfig)
    private var config: Config
    
    @Environment(\.colorPickerBarStyle)
    private var style: Style

    @Environment(\.colorScheme)
    private var colorScheme

    public var body: some View {
        HStack(spacing: 0) {
            picker
            if !config.barColors.isEmpty {
                divider
                scrollView
            }
            if shouldShowResetButton {
                divider
                resetButton
            }
        }
        .labelsHidden()
        .frame(maxHeight: style.selectedColorSize)
    }
}

private extension ColorPickerBar {

    func colorButton(for color: Color) -> some View {
        Button {
            value.wrappedValue = color
        } label: {
            let size = scrollViewCircleSize(for: color)
            colorCircle(for: color)
                .frame(width: size, height: size)
                .padding(.vertical, isSelected(color) ? 0 : 5)
                .animation(style.animation, value: value.wrappedValue)
        }.buttonStyle(.plain)
    }

    @ViewBuilder
    func colorCircle(for color: Color) -> some View {
        Circle()
            .stroke(scrollViewCircleStroke(for: color), lineWidth: 1)
            .background(scrollViewCircleBackground(for: color))
    }

    var divider: some View {
        Divider()
    }

    var picker: some View {
        ColorPicker(
            String(localized: title, bundle: titleBundle),
            selection: value ?? .clear,
            supportsOpacity: config.opacity
        )
        .fixedSize()
        .padding(.trailing, style.spacing)
    }

    var resetButton: some View {
        Button {
            value.wrappedValue = config.resetValue
        } label: {
            style.resetButtonImage
                .resizable()
                .frame(width: style.colorSize, height: style.colorSize)
        }
        .padding(.leading, style.spacing)
    }

    var scrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: style.spacing) {
                ForEach(Array(config.barColors.enumerated()), id: \.offset) {
                    colorButton(for: $0.element)
                }
            }
            .padding(.horizontal, style.spacing)
            .padding(.vertical, 2)
        }.frame(maxWidth: .infinity)
    }

    @ViewBuilder
    func scrollViewCircleBackground(for color: Color) -> some View {
        if color == .clear {
            Image(systemName: "circle.dotted")
                .resizable()
        } else {
            Circle()
                .fill(color)
                .shadow(radius: 1, y: 1)
        }
    }

    func scrollViewCircleSize(for color: Color) -> Double {
        isSelected(color) ? style.selectedColorSize : style.colorSize
    }

    func scrollViewCircleStroke(for color: Color) -> Color {
        if color == .black && colorScheme == .dark { return .white }
        return .clear
    }
}

private extension ColorPickerBar {

    var hasChanges: Bool {
        value.wrappedValue != config.resetValue
    }

    var shouldShowResetButton: Bool {
        config.resetButton && hasChanges
    }

    func isSelected(_ color: Color) -> Bool {
        value.wrappedValue == color
    }

    func select(color: Color) {
        value.wrappedValue = color
    }
}

public extension Collection where Element == Color {

    /// Get a standard list of `ColorPickerBar` colors.
    static var colorPickerBarColors: [Color] {
        [
            .black, .gray, .white,
            .red, .pink, .orange, .yellow,
            .indigo, .purple, .blue, .cyan, .teal, .mint,
            .green, .brown
        ]
    }

    static func colorPickerBarColors(withClearColor: Bool) -> [Color] {
        let standard = colorPickerBarColors
        guard withClearColor else { return standard }
        return [.clear] + standard
    }
}

#Preview {

    struct Preview: View {

        @State
        private var color1: Color = .red

        @State
        private var color2: Color = .yellow

        @State
        private var color3: Color = .purple

        @State
        private var optionalColor: Color?

        @State
        var optionalDouble: Double?

        var pickers: some View {
            VStack(alignment: .leading) {
                ColorPickerBar(
                    "Pick Color",
                    value: $color1
                )
                .colorPickerBarConfig(.init(
                    barColors: [.red, .green, .blue]
                ))
                ColorPickerBar(
                    "Pick Color",
                    value: $color2
                )
                ColorPickerBar(
                    "Pick Color",
                    value: $color3
                )
                ColorPickerBar(
                    "Pick Color",
                    value: $optionalColor
                )
                .colorPickerBarConfig(.init(
                    barColors: .colorPickerBarColors(withClearColor: true),
                    opacity: false,
                    resetButton: true,
                    resetValue: nil
                ))
            }
        }

        var body: some View {
            VStack {
                pickers
                pickers
                    .background(Color.black)
                    .colorScheme(.dark)
            }
        }
    }

    return Preview()
}
#endif
