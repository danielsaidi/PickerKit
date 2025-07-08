//
//  FontPickerFont+OpenDyslexic.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2025-07-07.
//
//  Courtesy by OpenDyslexic.org
//  Please consider donating at https://opendyslexic.org
//

import SwiftUI

public extension FontPickerFont {

    /// The OpenDyslexic picker display scale.
    static let openDyslexicPickerDisplayScale: Double = 0.75

    /// A regular OpenDyslexic font variant.
    static let openDyslexic = FontPickerFont(
        from: .openDyslexic,
        pickerDisplayScale: openDyslexicPickerDisplayScale
    )

    /// A bold OpenDyslexic font variant.
    static let openDyslexicBold = FontPickerFont(
        from: .openDyslexicBold,
        pickerDisplayScale: openDyslexicPickerDisplayScale
    )

    /// A bold italic OpenDyslexic font variant.
    static let openDyslexicBoldItalic = FontPickerFont(
        from: .openDyslexicBoldItalic,
        pickerDisplayScale: openDyslexicPickerDisplayScale
    )

    /// An italic OpenDyslexic font variant.
    static let openDyslexicItalic = FontPickerFont(
        from: .openDyslexicItalic,
        pickerDisplayScale: openDyslexicPickerDisplayScale
    )
}

public extension FontPickerFont {

    /// A collection of all OpenDyslexic font variants.
    static var openDyslexicFonts: [FontPickerFont] { .openDyslexicFonts }
}

public extension Collection where Element == FontPickerFont {

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
        ForEach(FontPickerFont.openDyslexicFonts) { font in
            Text(font.displayName)
                .font(.fixed(font, size: 15))
        }
    }
}
