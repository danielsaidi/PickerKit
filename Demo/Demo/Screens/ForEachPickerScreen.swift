//
//  ForEachPickerScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-10.
//

import PickerKit
import QuickLook
import SwiftUI

struct ForEachPickerScreen: View {

    struct Model: Identifiable, Hashable {
        let id: Int
        var name: String { "Item \(id + 1)" }
    }

    @State private var items = (0..<10).map(Model.init)
    @State private var selection: Model?

    var body: some View {
        List {
            ForEachPicker(selection: $selection, values: items) { item in
                PickerItem(
                    item.name,
                    isSelected: item == selection
                )
            }
        }
        .navigationTitle("ForEach Picker")
    }
}

#Preview {
    ForEachPickerScreen()
}
