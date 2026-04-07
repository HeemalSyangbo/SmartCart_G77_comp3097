//
//  ListDetailView.swift
//  SmartCart
//
//  Author: Heemal Syangbo - 101532464
//  Edited by:
//  - Anudhin Thomas - 101516423
//    Changes: Detail screen flow and item presentation
//  - Jeffin Yohannan - 101512594
//    Changes: Tax summary and UI review
//
//  Description:
//  This screen shows all items inside a selected shopping list.
//  It also displays subtotal, tax, and final total at the bottom.
//  Users can add and delete items from the list.
//

import SwiftUI
import SwiftData

struct ListDetailView: View {
    let list: ShoppingList

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var itemToDelete: CartItem?
    @State private var showDeleteAlert = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(.systemGray6), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                headerSection

                if list.sortedItems.isEmpty {
                    emptyStateView
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(list.sortedItems, id: \.createdAt) { item in
                                itemCard(item)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                }

                summarySection
            }
            .padding(.top)
        }
        .navigationBarBackButtonHidden(true)
        .alert("Delete Item?", isPresented: $showDeleteAlert, presenting: itemToDelete) { item in
            Button("Delete", role: .destructive) {
                deleteItem(item)
            }
            Button("Cancel", role: .cancel) {
                itemToDelete = nil
            }
        } message: { item in
            Text("Are you sure you want to delete '\(item.name)'?")
        }
    }

    private var headerSection: some View {
        HStack {
            CircleButtonView(systemName: "chevron.left") {
                dismiss()
            }

            Spacer()

            VStack(spacing: 2) {
                Text(list.name)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)

                Text("Shopping List Details")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }

            Spacer()

            NavigationLink(destination: AddItemView(list: list)) {
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

    private var emptyStateView: some View {
        VStack(spacing: 14) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 100, height: 100)
                    .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)

                Image(systemName: "cart.badge.plus")
                    .font(.system(size: 38))
                    .foregroundColor(.black)
            }

            Text("No items in this list")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)

            Text("Tap the plus button to add your first item.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private func itemCard(_ item: CartItem) -> some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color(.systemGray6))
                    .frame(width: 44, height: 44)

                Image(systemName: "cart.fill")
                    .foregroundColor(.black)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.black)

                Text("Qty: \(item.quantity) • \(item.category)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(item.totalPrice, specifier: "%.2f")")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Text("$\(item.price, specifier: "%.2f") each")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Button {
                itemToDelete = item
                showDeleteAlert = true
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .padding(10)
                    .background(Color.red.opacity(0.08))
                    .clipShape(Circle())
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(22)
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
    }

    private var summarySection: some View {
        VStack(spacing: 14) {
            HStack {
                Text("Subtotal")
                    .foregroundColor(.black)

                Spacer()

                Text("$\(list.subtotal, specifier: "%.2f")")
                    .foregroundColor(.black)
            }

            HStack {
                Text("Tax (13%)")
                    .foregroundColor(.gray)

                Spacer()

                Text("$\(list.taxAmount, specifier: "%.2f")")
                    .foregroundColor(.gray)
            }

            Divider()

            HStack {
                Text("Total")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Spacer()

                Text("$\(list.finalTotal, specifier: "%.2f")")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
        }
        .padding(18)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
        .padding(.horizontal)
        .padding(.bottom)
    }

    private func deleteItem(_ item: CartItem) {
        if let index = list.items.firstIndex(where: { $0.createdAt == item.createdAt }) {
            list.items.remove(at: index)
        }

        context.delete(item)

        do {
            try context.save()
        } catch {
            print("Failed to delete item: \(error.localizedDescription)")
        }
    }
}

#Preview {
    NavigationStack {
        ListDetailView(list: ShoppingList(name: "Groceries"))
    }
}
