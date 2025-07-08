//
//  FontPicker.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2022-03-17.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This picker lists ``FontPickerFont`` items in a `ForEach`
/// that properly renders each font.
///
/// The picker supports both optional and non-optional value
/// binding. It will wrap the provided `content` view within
/// a regular button that applies the value when it's tapped.
public struct FontPicker<Content: View>: View {

    /// Create a font picker with an optional binding.
    ///
    /// - Parameters:
    ///   - selection: The selected font.
    ///   - fonts: The fonts to display, by default `.systemFonts`.
    ///   - content: The list item content view, by default a ``FontPickerItem``.
    public init(
        selection: Binding<FontPickerFont?>,
        fonts: [FontPickerFont]? = nil,
        content: @escaping (FontPickerFont) -> Content
    ) {
        self.selection = selection
        self.fonts = fonts ?? FontPickerFont.systemFonts
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
        ForEachPicker(
            selection: selection,
            values: fonts,
            content: content
        )
    }
}

public extension FontPicker where Content == FontPickerItem {

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
        self.fonts = fonts ?? FontPickerFont.systemFonts
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
                FontPicker(
                    selection: $selection,
                    fonts: .openDyslexicFonts + .systemFonts
                )
                .tint(.primary)
            }
        }
    }

    return Preview()
}
