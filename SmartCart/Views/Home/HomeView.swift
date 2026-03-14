import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ShoppingList.createdAt) private var lists: [ShoppingList]

    @State private var showAddListSheet = false
    @State private var newListName = ""

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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAddListSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddListSheet) {
            NavigationStack {
                Form {
                    Section("New Shopping List") {
                        TextField("List name", text: $newListName)
                    }

                    Section {
                        Button("Save List") {
                            saveNewList()
                        }
                        .disabled(newListName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }
                .navigationTitle("Create List")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            newListName = ""
                            showAddListSheet = false
                        }
                    }
                }
            }
        }
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

    private func saveNewList() {
        let trimmedName = newListName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        let newList = ShoppingList(name: trimmedName)
        modelContext.insert(newList)

        do {
            try modelContext.save()
            newListName = ""
            showAddListSheet = false
        } catch {
            print("Failed to save new list: \(error)")
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [ShoppingList.self, CartItem.self], inMemory: true)
}
