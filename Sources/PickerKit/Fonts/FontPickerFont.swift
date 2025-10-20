//
//  FontPickerFont.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2022-03-17.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import FontKit
import Foundation
import SwiftUI

/// A platform-agnostic font picker font.
///
/// You can use ``systemFonts`` to get all the system fonts that are provided
/// by the operating system.
///
/// You can use ``CustomFont`` fonts to use custom fonts with the font picker.
public struct FontPickerFont: Codable, CustomFontRepresentable, Equatable, Hashable, Identifiable, Sendable {

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
        self.systemFontScaleFactor = 1
    }

    /// Create a system picker font based on a custom font.
    ///
    /// - Parameters:
    ///   - font: The custom font to use.
    public init(
        from font: CustomFont
    ) {
        self.name = font.name
        self.displayName = font.displayName
        self.systemFontScaleFactor = font.systemFontScaleFactor
    }

    /// The font's unique identifier.
    public var id: String { name }

    // The font name.
    public let name: String

    /// The font display name
    public let displayName: String

    /// The approximate system font scale factor.
    public let systemFontScaleFactor: Double
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

#Preview {

    List {
        ForEach(FontPickerFont.systemFonts) { font in
            Text(font.name)
                .font(.fixed(font, size: 15))
        }
    }
}
