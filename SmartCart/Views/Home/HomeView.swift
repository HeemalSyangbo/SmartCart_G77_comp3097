//
//  HomeView.swift
//  SmartCart
//
//  Author: Heemal Syangbo - 101532464
//  Edited by:
//  - Anudhin Thomas - 101516423
//    Changes: Home screen layout and navigation support
//  - Jeffin Yohannan - 101512594
//    Changes: Shopping list display review
//
//  Description:
//  This screen displays all shopping lists.
//  Users can create, open, and delete shopping lists.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \ShoppingList.createdAt, order: .forward) private var shoppingLists: [ShoppingList]

    @State private var showAddAlert = false
    @State private var newListName = ""
    @State private var listToDelete: ShoppingList?
    @State private var showDeleteAlert = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(.systemGray6), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 22) {
                headerSection

                VStack(alignment: .leading, spacing: 6) {
                    Text("Shopping Lists")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)

                    Text("Create and manage your shopping lists")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                if shoppingLists.isEmpty {
                    emptyStateView
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(Array(shoppingLists.enumerated()), id: \.element.createdAt) { _, list in
                                NavigationLink(destination: ListDetailView(list: list)) {
                                    shoppingListCard(list)
                                }
                                .buttonStyle(.plain)
                                .contextMenu {
                                    Button(role: .destructive) {
                                        listToDelete = list
                                        showDeleteAlert = true
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                }

                Spacer()
            }
            .padding(.top)
        }
        .navigationBarBackButtonHidden(true)
        .alert("New Shopping List", isPresented: $showAddAlert) {
            TextField("Enter list name", text: $newListName)

            Button("Save") {
                addShoppingList()
            }

            Button("Cancel", role: .cancel) {
                newListName = ""
            }
        } message: {
            Text("Create a new shopping list.")
        }
        .alert("Delete Shopping List?", isPresented: $showDeleteAlert, presenting: listToDelete) { list in
            Button("Delete", role: .destructive) {
                deleteList(list)
            }
            Button("Cancel", role: .cancel) {
                listToDelete = nil
            }
        } message: { list in
            Text("Are you sure you want to delete '\(list.name)'?")
        }
    }

    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("SmartCart")
                    .font(.system(size: 30, weight: .heavy))
                    .foregroundColor(.black)

                Text("Shopping List & Tax Calculator")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }

            Spacer()

            Button {
                showAddAlert = true
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 52, height: 52)

                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
            }
        }
        .padding(.horizontal)
    }

    private func shoppingListCard(_ list: ShoppingList) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(list.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    Text("\(list.items.count) item\(list.items.count == 1 ? "" : "s")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.headline)
                    .foregroundColor(.gray.opacity(0.7))
            }

            Divider()

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text("$\(list.finalTotal, specifier: "%.2f")")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }

                Spacer()

                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .frame(width: 44, height: 44)

                    Image(systemName: "cart.fill")
                        .foregroundColor(.black)
                }
            }
        }
        .padding(18)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
    }

    private var emptyStateView: some View {
        VStack(spacing: 14) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 100, height: 100)
                    .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)

                Image(systemName: "cart")
                    .font(.system(size: 38))
                    .foregroundColor(.black)
            }

            Text("No shopping lists yet")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)

            Text("Tap the plus button to create your first shopping list.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private func addShoppingList() {
        let trimmedName = newListName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        let newList = ShoppingList(name: trimmedName)
        context.insert(newList)
        newListName = ""
    }

    private func deleteList(_ list: ShoppingList) {
        context.delete(list)

        do {
            try context.save()
        } catch {
            print("Failed to delete list: \(error.localizedDescription)")
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
