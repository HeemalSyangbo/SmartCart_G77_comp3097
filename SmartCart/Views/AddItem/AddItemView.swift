import SwiftUI

struct AddItemView: View {
    @State private var itemName = ""
    @State private var price = ""
    @State private var quantity = 1
    @State private var category = "General"

    private let categories = ["General", "Groceries", "Pharmacy", "Electronics"]

    var body: some View {
        Form {
            Section("Item Info") {
                TextField("Item name", text: $itemName)

                TextField("Price", text: $price)
                    .keyboardType(.decimalPad)

                Stepper("Quantity: \(quantity)", value: $quantity, in: 1...99)

                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) { cat in
                        Text(cat).tag(cat)
                    }
                }
            }

            Section {
                Button("Save Item") {
                    // UI milestone: no real save yet
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle("Add Item")
    }
}

#Preview {
    NavigationStack {
        AddItemView()
    }
}
