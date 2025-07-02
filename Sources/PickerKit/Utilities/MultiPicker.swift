//
//  MultiPicker.swift
//  PickerKit
//
//  Created by Daniel Saidi on 2021-08-20.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This generic picker lists any values and binds
/// its `selection` to an external value.
///
/// You can use this view instead of the native `Picker`, to
/// select multiple items in a list or form, and to get more
/// control over the list item views.
public struct MultiPicker<Item: Identifiable, ItemView: View>: View {

    /// Create a for-each multi-picker.
    ///
    /// - Parameters:
    ///   - items: The items to list in the picker.
    ///   - selection: The current selection.
    ///   - itemView: A item view builder.
    public init(
        items: [Item],
        selection: Binding<[Item]>,
        itemView: @escaping ItemViewBuilder
    ) {
        self.items = items
        self.selection = selection
        self.itemView = itemView
    }

    private let items: [Item]
    private let selection: Binding<[Item]>
    private let itemView: ItemViewBuilder

    public typealias ItemViewBuilder = (_ item: Item, _ isSelected: Bool) -> ItemView

    @Environment(\.dismiss)
    public var dismiss

    public var body: some View {
        ForEach(items) { item in
            Button(action: { toggleSelection(for: item) }, label: {
                HStack {
                    itemView(item, isSelected(item))
                }
            })
        }
    }
}

private extension MultiPicker {

    var selectedIds: [Item.ID] {
        selection.wrappedValue.map { $0.id }
    }

    func isSelected(_ item: Item) -> Bool {
        selectedIds.contains(item.id)
    }

    func toggleSelection(for item: Item) {
        if isSelected(item) {
            selection.wrappedValue = selection.wrappedValue.filter { $0.id != item.id }
        } else {
            selection.wrappedValue.append(item)
        }
    }
}

#Preview {

    struct PreviewModel: Identifiable {
        let id: Int
    }

    struct Preview: View {

        @State var selection1: [PreviewModel] = []
        @State var selection2: [PreviewModel] = []

        func createValues() -> [PreviewModel] {
            (0...10).map { .init(id: $0) }
        }

        var body: some View {
            NavigationView {
                List {
                    MultiPicker(items: createValues(), selection: $selection1) { item, selected in
                        PickerItem(isSelected: selected) {
                            Text("\(item.id)")
                        }
                    }
                }
                .navigationTitle("Pick multiple items")
            }
        }
    }

    struct PreviewItem: Identifiable, Equatable {

        let name: String

        var id: String { name }

        static let all = [
            PreviewItem(name: "Item #1"),
            PreviewItem(name: "Item #2"),
            PreviewItem(name: "Item #3"),
            PreviewItem(name: "Item #4"),
            PreviewItem(name: "Item #5"),
            PreviewItem(name: "Item #6"),
            PreviewItem(name: "Item #7"),
            PreviewItem(name: "Item #8"),
            PreviewItem(name: "Item #9"),
            PreviewItem(name: "Item #10"),
            PreviewItem(name: "Item #11"),
            PreviewItem(name: "Item #12"),
            PreviewItem(name: "Item #13"),
            PreviewItem(name: "Item #14"),
            PreviewItem(name: "Item #15")
        ]
    }

    return Preview()
}
