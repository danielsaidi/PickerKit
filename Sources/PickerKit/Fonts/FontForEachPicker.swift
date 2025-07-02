//
//  FontForEachPicker.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2022-03-17.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This picker lists the provided fonts in a `ForEach`.
///
/// The view will by default render a ``FontPickerItem`` for
/// each font, and properly render the font in the list.
public struct FontForEachPicker<Content: View>: View {

    /// Create a font picker with an optional binding.
    ///
    /// - Parameters:
    ///   - selection: The selected font.
    ///   - fonts: The fonts to display, by default `all`.
    ///   - content: The list item content view, by default a ``FontPickerItem``.
    public init(
        selection: Binding<FontPickerFont?>,
        fonts: [FontPickerFont]? = nil,
        content: @escaping (FontPickerFont) -> Content
    ) {
        self.selection = selection
        self.fonts = fonts ?? .all
        self.content = content
    }

    /// Create a font picker with a non-optional binding.
    ///
    /// - Parameters:
    ///   - selection: The selected font.
    ///   - fonts: The fonts to display, by default `all`.
    ///   - content: The list item content view, by default a ``FontPickerItem``.
    public init(
        selection: Binding<FontPickerFont>,
        fonts: [FontPickerFont]? = nil,
        content: @escaping (FontPickerFont) -> Content
    ) {
        let optionalBinding: Binding<FontPickerFont?> = .init(
            get: { selection.wrappedValue },
            set: {
                guard let new = $0 else { return }
                selection.wrappedValue = new
            }
        )
        self.init(
            selection: optionalBinding,
            fonts: fonts,
            content: content
        )
    }

    private var selection: Binding<FontPickerFont?>
    private let fonts: [FontPickerFont]
    private let content: (FontPickerFont) -> Content

    public var body: some View {
        ForEach(fonts) { font in
            Button {
                selection.wrappedValue = font
            } label: {
                FontPickerItem(
                    font: font,
                    isSelected: font == selection.wrappedValue
                )
            }
            .tint(.primary)
        }
    }
}

public extension FontForEachPicker where Content == FontPickerItem {

    /// Create a font picker with an optional binding.
    ///
    /// This initializer applies a ``FontPickerItem`` as the
    /// item content view.
    ///
    /// - Parameters:
    ///   - selection: The selected font.
    ///   - fonts: The fonts to display, by default `all`.
    init(
        selection: Binding<FontPickerFont?>,
        fonts: [FontPickerFont]? = nil
    ) {
        self.selection = selection
        self.fonts = fonts ?? .all
        self.content = { FontPickerItem(font: $0, isSelected: selection.wrappedValue == $0) }
    }

    /// Create a font picker with a non-optional binding.
    ///
    /// This initializer applies a ``FontPickerItem`` as the
    /// item content view. 
    ///
    /// - Parameters:
    ///   - selection: The selected font.
    ///   - fonts: The fonts to display, by default `all`.
    init(
        selection: Binding<FontPickerFont>,
        fonts: [FontPickerFont]? = nil
    ) {
        let optionalBinding: Binding<FontPickerFont?> = .init(
            get: { selection.wrappedValue },
            set: {
                guard let new = $0 else { return }
                selection.wrappedValue = new
            }
        )
        self.init(
            selection: optionalBinding,
            fonts: fonts
        )
    }
}

#Preview {

    struct Preview: View {

        @State var selection: FontPickerFont?

        var body: some View {
            List {
                FontForEachPicker(
                    selection: $selection,
                    fonts: .all
                )
                .tint(.primary)
            }
        }
    }

    return Preview()
}
