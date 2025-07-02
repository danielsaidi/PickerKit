//
//  MultiPickerScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-10.
//

import PickerKit
import QuickLook
import SwiftUI

struct MultiPickerScreen: View {

    struct Model: Identifiable, Hashable {
        let id: Int
        var name: String { "Item \(id + 1)" }
    }

    @State private var items = (0..<5).map(Model.init)
    @State private var selection1: [Model] = []
    @State private var selection2: [Model] = []
    @State private var selection3: [Model] = []

    var body: some View {
        List {
            listSection(1, selection: $selection1)
            listSection(2, selection: $selection2)
            listSection(3, selection: $selection3)
        }
        .navigationTitle("Multi Picker")
    }

    func listSection(
        _ number: Int,
        selection: Binding<[Model]>
    ) -> some View {
        Section("Section \(number)") {
            MultiPicker(
                items: items,
                selection: selection
            ) { item, isSelected in
                PickerItem(isSelected: isSelected) {
                    Text(item.name).tag(item)
                }
            }
        }
    }
}

#Preview {
    MultiPickerScreen()
}
