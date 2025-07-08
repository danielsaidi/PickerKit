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

    /// A regular OpenDyslexic font variant.
    static let openDyslexic = FontPickerFont(
        from: .openDyslexic
    )

    /// A bold OpenDyslexic font variant.
    static let openDyslexicBold = FontPickerFont(
        from: .openDyslexicBold
    )

    /// A bold italic OpenDyslexic font variant.
    static let openDyslexicBoldItalic = FontPickerFont(
        from: .openDyslexicBoldItalic
    )

    /// An italic OpenDyslexic font variant.
    static let openDyslexicItalic = FontPickerFont(
        from: .openDyslexicItalic
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

    let size = 15.0

    List {
        Text("OpenDyslexic")
            .font(.system(size: size))
        ForEach(FontPickerFont.openDyslexicFonts) { font in
            Text(font.displayName)
                .font(.fixed(font, size: size))
        }
    }
}
