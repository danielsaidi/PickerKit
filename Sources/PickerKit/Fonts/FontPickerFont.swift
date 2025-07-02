//
//  FontPickerFont.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2022-03-17.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// This struct is used by the platform-specific font picker
/// implementations, to make the font platform-agnostic.
public struct FontPickerFont: Equatable, Hashable, Identifiable, Sendable {

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
        self.fontName = fontName
        self.displayName = displayName ?? fontName
    }

    // The font name.
    public let fontName: String

    /// The font display name
    public let displayName: String
}

public extension FontPickerFont {

    /// The unique ID.
    var id: String { fontName.lowercased() }

    /// Get all available font picker fonts.
    static var allFonts: [FontPickerFont] {
        let all = FontRepresentable.allFonts
        let sorted = all.sorted { $0.displayName < $1.displayName }
        return sorted
    }
}

public extension Collection where Element == FontPickerFont {
    
    /// Get all available font picker fonts.
    static var all: [FontPickerFont] {
        Element.allFonts
    }
    
    /// Move a certain font topmost in the list.
    func moveTopmost(_ topmost: String) -> [FontPickerFont] {
        let topmost = topmost.trimmingCharacters(in: .whitespaces)
        let exists = contains { $0.fontName.lowercased() == topmost.lowercased() }
        guard exists else { return Array(self) }
        var filtered = filter { $0.fontName.lowercased() != topmost.lowercased() }
        let new = FontPickerFont(fontName: topmost)
        filtered.insert(new, at: 0)
        return filtered
    }
}

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

private extension NSFont {
    
    /// Get all available NSFont families.
    static var allFonts: [FontPickerFont] {
        NSFontManager.shared
            .availableFontFamilies
            .map { FontPickerFont(fontName: $0) }
    }
}
#else
import UIKit

private extension UIFont {
    
    /// Get all available NSFont families.
    static var allFonts: [FontPickerFont] {
        UIFont.familyNames
            .map { FontPickerFont(fontName: $0) }
    }
}
#endif

/// Create a ``FontPickerFont``-based font.
func Font(
    _ font: FontPickerFont,
    size: Double
) -> Font {
    .custom(font.fontName, size: size)
}

public extension Font {

    /// Create a ``FontPickerFont``-based font.
    static func custom(
        _ font: FontPickerFont,
        size: Double
    ) -> Font {
        .custom(font.fontName, size: size)
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
        ForEach(FontPickerFont.allFonts) { font in
            Text(font.fontName)
                .font(font, size: 20)
        }
    }
}
