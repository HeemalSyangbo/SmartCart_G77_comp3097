import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ShoppingList.createdAt) private var lists: [ShoppingList]

    var body: some View {
        List {
            Section("Shopping Lists") {
                if lists.isEmpty {
                    Text("No shopping lists yet")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(lists) { list in
                        NavigationLink {
                            ListDetailView(list: list)
                        } label: {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(list.name)
                                    .font(.headline)

                                Text("\(list.items.count) items")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 6)
                        }
                    }
                }
            }
        }
        .navigationTitle("SmartCart")
        .onAppear {
            insertDefaultListsIfNeeded()
        }
    }

    private func insertDefaultListsIfNeeded() {
        guard lists.isEmpty else { return }

        let defaultLists = [
            ShoppingList(name: "Groceries"),
            ShoppingList(name: "Pharmacy"),
            ShoppingList(name: "Electronics")
        ]

        for list in defaultLists {
            modelContext.insert(list)
        }

        do {
            try modelContext.save()
        } catch {
            print("Failed to save default lists: \(error)")
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [ShoppingList.self, CartItem.self], inMemory: true)
}
