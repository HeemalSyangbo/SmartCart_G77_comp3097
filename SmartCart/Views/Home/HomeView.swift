import SwiftUI

struct ShoppingList: Identifiable {
    let id = UUID()
    let title: String
    let itemCount: Int
    let total: Double
}

struct HomeView: View {
    private let lists: [ShoppingList] = [
        .init(title: "Groceries", itemCount: 12, total: 84.55),
        .init(title: "Pharmacy", itemCount: 6, total: 32.10),
        .init(title: "Electronics", itemCount: 3, total: 299.99)
    ]

    var body: some View {
        List {
            Section("Shopping Lists") {
                ForEach(lists) { list in
                    NavigationLink {
                        ListDetailView(listName: list.title)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(list.title)
                                .font(.headline)
                            Text("\(list.itemCount) items • $\(list.total, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
        }
        .navigationTitle("SmartCart")
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
