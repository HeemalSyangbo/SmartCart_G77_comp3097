import SwiftUI

struct CartItem: Identifiable {
    let id = UUID()
    let name: String
    let qty: Int
    let price: Double
}

struct ListDetailView: View {
    let listName: String

    private let items: [CartItem] = [
        .init(name: "Milk", qty: 2, price: 4.50),
        .init(name: "Bread", qty: 1, price: 3.25),
        .init(name: "Eggs", qty: 1, price: 5.99)
    ]

    private var subtotal: Double {
        items.reduce(0) { $0 + (Double($1.qty) * $1.price) }
    }

    private var tax: Double { subtotal * 0.13 }
    private var total: Double { subtotal + tax }

    var body: some View {
        List {
            Section("Items") {
                ForEach(items) { item in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.name).font(.headline)
                            Text("Qty: \(item.qty)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text("$\(Double(item.qty) * item.price, specifier: "%.2f")")
                            .font(.headline)
                    }
                    .padding(.vertical, 6)
                }
            }

            Section("Summary") {
                summaryRow("Subtotal", subtotal)
                summaryRow("Tax (13%)", tax)
                summaryRow("Total", total, bold: true)
            }
        }
        .navigationTitle(listName)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    AddItemView()
                } label: {
                    Image(systemName: "plus")
                }
            }
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
        ListDetailView(listName: "Groceries")
    }
}
