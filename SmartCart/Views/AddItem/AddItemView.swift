import SwiftUI
import SwiftData

struct AddItemView: View {
    let list: ShoppingList

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

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
                    saveItem()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .disabled(itemName.trimmingCharacters(in: .whitespaces).isEmpty || Double(price) == nil)
            }
        }
        .navigationTitle("Add Item")
    }

    private func saveItem() {
        guard let priceValue = Double(price),
              !itemName.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }

        let newItem = CartItem(
            name: itemName,
            price: priceValue,
            quantity: quantity,
            category: category
        )

        list.items.append(newItem)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to save item: \(error)")
        }
    }
}

#Preview {
    NavigationStack {
        AddItemView(list: ShoppingList(name: "Groceries"))
    }
    .modelContainer(for: [ShoppingList.self, CartItem.self], inMemory: true)
}
