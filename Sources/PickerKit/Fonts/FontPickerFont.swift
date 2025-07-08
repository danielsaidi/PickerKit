//
//  FontPickerFont.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2022-03-17.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// A platform-agnostic font picker font.
///
/// You can use ``systemFonts`` to get all system fonts that
/// are provided by the operating system.
///
/// You can create a ``CustomFont``-based picker font if you
/// want to add custom fonts to the picker. When you do, the
/// ``pickerDisplayScale`` can be used to harmonize the font
/// display size in the picker.
public struct FontPickerFont: Codable, Equatable, Hashable, Identifiable, Sendable {

    /// Create a system picker font based on a font name.
    ///
    /// - Parameters:
    ///   - fontName: The font name.
    ///   - displayName: A custom font display name, if any.
    public init(
        fontName: String,
        displayName: String? = nil
    ) {
        let fontName = fontName.capitalized
        self.name = fontName
        self.displayName = displayName ?? fontName
        self.pickerDisplayScale = 1
    }

    /// Create a system picker font based on a custom font.
    ///
    /// - Parameters:
    ///   - font: The custom font to use.
    ///   - pickerDisplayScale: The picker display scale, by default `1`.
    public init(
        from font: CustomFont,
        pickerDisplayScale: Double = 1
    ) {
        self.name = font.name
        self.displayName = font.displayName
        self.pickerDisplayScale = pickerDisplayScale
    }

    /// The font's unique identifier.
    public var id: String { name }

    // The font name.
    public let name: String

    /// The font display name
    public let displayName: String

    /// The font size scale to apply in the picker
    public let pickerDisplayScale: Double
}

public extension FontPickerFont {

    /// Get all available font picker fonts.
    static var systemFonts: [FontPickerFont] {
        let all = FontRepresentable.systemFonts
        let sorted = all.sorted { $0.displayName < $1.displayName }
        return sorted
    }
}

public extension Collection where Element == FontPickerFont {
    
    /// Get all available font picker fonts.
    static var systemFonts: [FontPickerFont] {
        Element.systemFonts
    }
    
    /// Move a certain font topmost in the list.
    func moveTopmost(_ topmost: String) -> [FontPickerFont] {
        let topmost = topmost.trimmingCharacters(in: .whitespaces)
        let exists = contains { $0.name.lowercased() == topmost.lowercased() }
        guard exists else { return Array(self) }
        var filtered = filter { $0.name.lowercased() != topmost.lowercased() }
        let new = FontPickerFont(fontName: topmost)
        filtered.insert(new, at: 0)
        return filtered
    }
}

private extension FontRepresentable {

    /// Get all available system fonts.
    static var systemFonts: [FontPickerFont] {
        #if canImport(AppKit) && !targetEnvironment(macCatalyst)
        NSFontManager.shared
            .availableFontFamilies
            .map { FontPickerFont(fontName: $0) }
        #else
        UIFont.familyNames
            .map { FontPickerFont(fontName: $0) }
        #endif
    }
}

public extension Font {

    /// Returns a ``FontPickerFont`` with a dynamic size.
    static func dynamic(
      _ font: FontPickerFont?,
      size: CGFloat,
      fallback: Font = .body
    ) -> Font {
        if let font {
            .custom(font.name, size: size)
        } else {
            fallback
        }
    }

    /// Returns a ``FontPickerFont`` with a fixed size.
    static func fixed(
      _ font: FontPickerFont?,
      size: CGFloat,
      fallback: Font = .body
    ) -> Font {
        if let font {
            .custom(font.name, fixedSize: size)
        } else {
            fallback
        }
    }

    /// Returns a ``FontPickerFont`` with a style-relative size.
    static func relative(
        _ font: FontPickerFont?,
        size: CGFloat,
        relativeTo style: Font.TextStyle,
        fallback: Font = .body
    ) -> Font {
        if let font {
            .custom(font.name, size: size, relativeTo: style)
        } else {
            fallback
        }
    }
}

public extension Font {

    /// Create a ``FontPickerFont``-based font.
    static func custom(
        _ font: FontPickerFont,
        size: Double
    ) -> Font {
        .custom(font.name, size: size)
    }
}

public extension View {

    /// Apply a certain ``FontPickerFont``.
    func font(
        _ font: FontPickerFont,
        size: Double
    ) -> some View {
        self.font(.custom(font, size: size))
    }
}

#Preview {

    List {
        ForEach(FontPickerFont.systemFonts) { font in
            Text(font.name)
                .font(font, size: 20)
        }
    }
}
