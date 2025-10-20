//
//  FontPickerScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-10.
//

import PickerKit
import QuickLook
import SwiftUI

struct FontPickerScreen: View {

    @State private var selection: FontPickerFont?

    var body: some View {
        List {
            Section("Preview") {
                Text("The quick brown fox jumps over the lazy dog.")
                    .font(font)
            }

            Section("Custom Fonts") {
                FontPicker(
                    selection: $selection,
                    fonts: .openDyslexicFonts
                )
            }
            Section("System Fonts") {
                FontPicker(selection: $selection)
            }
        }
        .navigationTitle("Font Picker")
    }
}

private extension FontPickerScreen {

    var font: Font {
        guard let selection else { return .body }
        return .relative(selection, size: 15, relativeTo: .body)
    }
}

#Preview {
    FontPickerScreen()
}
