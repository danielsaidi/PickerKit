//
//  CustomFont+OpenDyslexic.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2025-07-07.
//
//  Courtesy by OpenDyslexic.org
//  Please consider donating at https://opendyslexic.org
//

import SwiftUI

public extension CustomFont {

    /// A regular OpenDyslexic font variant.
    static let openDyslexic = CustomFont(
        name: "OpenDyslexic-Regular",
        displayName: "OpenDyslexic Regular",
        fileExtension: "otf",
        bundle: .module
    )

    /// A bold OpenDyslexic font variant.
    static let openDyslexicBold = CustomFont(
        name: "OpenDyslexic-Bold",
        displayName: "OpenDyslexic Bold",
        fileExtension: "otf",
        bundle: .module
    )

    /// A bold italic OpenDyslexic font variant.
    static let openDyslexicBoldItalic = CustomFont(
        name: "OpenDyslexic-Bold-Italic",
        displayName: "OpenDyslexic Bold Italic",
        fileExtension: "otf",
        bundle: .module
    )

    /// An italic OpenDyslexic font variant.
    static let openDyslexicItalic = CustomFont(
        name: "OpenDyslexic-Italic",
        displayName: "OpenDyslexic Italic",
        fileExtension: "otf",
        bundle: .module
    )
}

public extension CustomFont {

    /// A collection of all OpenDyslexic font variants.
    static var openDyslexicFonts: [CustomFont] { .openDyslexicFonts }
}

public extension Collection where Element == CustomFont {

    /// A collection of all OpenDyslexic font variants.
    static var openDyslexicFonts: [Element] {
        [
            .openDyslexic,
            .openDyslexicBold,
            .openDyslexicItalic,
            .openDyslexicBoldItalic
        ]
    }
}

#Preview {

    List {
        ForEach(CustomFont.openDyslexicFonts) { font in
            Text(font.displayName)
                .font(.fixed(font, size: 15))
        }
    }
}
