import SwiftUI
import SwiftData

struct ListDetailView: View {
    let list: ShoppingList

    @Environment(\.modelContext) private var modelContext

    private var subtotal: Double {
        list.items.reduce(0) { $0 + (Double($1.quantity) * $1.price) }
    }

    private var tax: Double { subtotal * 0.13 }
    private var total: Double { subtotal + tax }

    var body: some View {
        List {
            Section("Items") {
                if list.items.isEmpty {
                    Text("No items in this list yet")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(list.items) { item in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.name)
                                    .font(.headline)

                                Text("Qty: \(item.quantity)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)

                                Text(item.category)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Text("$\(Double(item.quantity) * item.price, specifier: "%.2f")")
                                .font(.headline)
                        }
                        .padding(.vertical, 6)
                    }
                    .onDelete(perform: deleteItems)
                }
            }

            Section("Summary") {
                summaryRow("Subtotal", subtotal)
                summaryRow("Tax (13%)", tax)
                summaryRow("Total", total, bold: true)
            }
        }
        .navigationTitle(list.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    AddItemView(list: list)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = list.items[index]
            modelContext.delete(item)
        }

        do {
            try modelContext.save()
        } catch {
            print("Failed to delete item: \(error)")
        }
    }

    @ViewBuilder
    private func summaryRow(_ title: String, _ value: Double, bold: Bool = false) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text("$\(value, specifier: "%.2f")")
                .fontWeight(bold ? .semibold : .regular)
        }
    }
}

#Preview {
    NavigationStack {
        ListDetailView(list: ShoppingList(name: "Groceries"))
    }
    .modelContainer(for: [ShoppingList.self, CartItem.self], inMemory: true)
}
