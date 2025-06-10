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
    ///   - axis: The picker axis, by default `.horizontal`.
    ///   - value: An optional color value binding.
    public init(
        _ title: String.LocalizationValue = "Pick Color",
        titleBundle: Bundle = .main,
        axis: Axis = .horizontal,
        value: Binding<Color?>
    ) {
        self.title = title
        self.titleBundle = titleBundle
        self.axis = axis
        self.value = value
    }

    /// Create a color picker bar with a non-optional binding.
    ///
    /// - Parameters:
    ///   - title: The picker title, by default "Pick Color".
    ///   - titleBundle: The picker title localization bundle, by default `.main`.
    ///   - axis: The picker axis, by default `.horizontal`.
    ///   - value: An non-optional color value binding.
    public init(
        _ title: String.LocalizationValue,
        titleBundle: Bundle = .main,
        axis: Axis = .horizontal,
        value: Binding<Color>
    ) {
        self.title = title
        self.titleBundle = titleBundle
        self.axis = axis
        self.value = .init(get: {
            value.wrappedValue
        }, set: {
            value.wrappedValue = $0 ?? .clear
        })
    }

    private let title: String.LocalizationValue
    private let titleBundle: Bundle
    private let axis: Axis
    private let value: Binding<Color?>
    
    @Environment(\.colorPickerBarConfig)
    private var config: Config
    
    @Environment(\.colorPickerBarStyle)
    private var style: Style

    @Environment(\.colorScheme)
    private var colorScheme

    public var body: some View {
        if axis == .vertical {
            VStack(spacing: 0) {
                bodyContent
            }
            .labelsHidden()
            .frame(maxWidth: style.selectedColorSize)
        } else {
            HStack(spacing: 0) {
                bodyContent
            }
            .labelsHidden()
            .frame(maxHeight: style.selectedColorSize)
        }
    }

    @ViewBuilder
    var bodyContent: some View {
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
}

private extension ColorPickerBar {

    func colorButton(for color: Color) -> some View {
        Button {
            value.wrappedValue = color
        } label: {
            let size = scrollViewCircleSize(for: color)
            colorCircle(for: color)
                .frame(width: size, height: size)
                .padding(colorButtonPaddingEdge, isSelected(color) ? 0 : 5)
                .animation(style.animation, value: value.wrappedValue)
        }
        .buttonStyle(.plain)
    }

    var colorButtonPaddingEdge: Edge.Set {
        axis == .horizontal ? .vertical : .horizontal
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
        .padding(pickerPaddingEdge, style.spacing)
    }

    var pickerPaddingEdge: Edge.Set {
        axis == .horizontal ? .trailing : .bottom
    }

    var resetButton: some View {
        Button {
            value.wrappedValue = config.resetValue
        } label: {
            style.resetButtonImage
                .resizable()
                .frame(width: style.colorSize, height: style.colorSize)
        }
        .padding(resetButtonPaddingEdge, style.spacing)
    }

    var resetButtonPaddingEdge: Edge.Set {
        axis == .horizontal ? .horizontal : .vertical
    }

    var scrollView: some View {
        ScrollView(scrollViewAxis, showsIndicators: false) {
            scrollViewStack
                .padding(scrollViewStylePaddingEdge, style.spacing)
                .padding(scrollViewStaticPaddingEdge, 2)
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    var scrollViewStack: some View {
        if axis == .horizontal {
            HStack(spacing: style.spacing) {
                scrollViewStackContent
            }
        } else {
            VStack(spacing: style.spacing) {
                scrollViewStackContent
            }
        }
    }

    var scrollViewStackContent: some View {
        ForEach(Array(config.barColors.enumerated()), id: \.offset) {
            colorButton(for: $0.element)
        }
    }

    var scrollViewAxis: Axis.Set {
        axis == .horizontal ? .horizontal : .vertical
    }

    var scrollViewStylePaddingEdge: Edge.Set {
        axis == .horizontal ? .horizontal : .vertical
    }

    var scrollViewStaticPaddingEdge: Edge.Set {
        axis == .horizontal ? .vertical : .horizontal
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

private struct Preview: View {

    let axis: Axis

    @State var color1: Color = .red
    @State var color2: Color = .yellow
    @State var color3: Color = .purple
    @State var color4: Color?

    @ViewBuilder
    var pickerStack: some View {
        switch axis {
        case .horizontal: VStack { pickerStackContent }
        case .vertical: HStack { pickerStackContent }
        }
    }

    @ViewBuilder
    var pickerStackContent: some View {
        ColorPickerBar(
            "Pick Color",
            axis: axis,
            value: $color1
        )
        .colorPickerBarConfig(.init(
            barColors: [.red, .green, .blue]
        ))
        ColorPickerBar(
            "Pick Color",
            axis: axis,
            value: $color2
        )
        ColorPickerBar(
            "Pick Color",
            axis: axis,
            value: $color3
        )
        ColorPickerBar(
            "Pick Color",
            axis: axis,
            value: $color4
        )
        .colorPickerBarConfig(.init(
            barColors: .colorPickerBarColors(withClearColor: true),
            opacity: false,
            resetButton: true,
            resetValue: nil
        ))
    }

    var body: some View {
        VStack {
            pickerStack
            pickerStack
                .background(Color.black)
                .colorScheme(.dark)
        }
    }
}

#Preview("Horizontal") {
    Preview(axis: .horizontal)
}

#Preview("Vertical") {
    Preview(axis: .vertical)
}
#endif
