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
            FontPicker(selection: $selection)
        }
        .navigationTitle("Font Picker")
    }
}

#Preview {
    FontPickerScreen()
}
