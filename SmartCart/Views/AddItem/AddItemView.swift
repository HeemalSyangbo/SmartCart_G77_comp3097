//
//  AddItemView.swift
//  SmartCart
//
//  Author: Heemal Syangbo - 101532464
//  Edited by:
//  - Anudhin Thomas - 101516423
//    Changes: Add item screen structure and field layout
//  - Jeffin Yohannan - 101512594
//    Changes: Input flow and category selection review
//
//  Description:
//  This screen allows the user to add a new item to a selected shopping list.
//  The user enters item name, price, quantity, and category.
//  The item is then saved into SwiftData through the parent shopping list.
//

import SwiftUI
import SwiftData

struct AddItemView: View {
    let list: ShoppingList

    @Environment(\.dismiss) private var dismiss

    @State private var itemName = ""
    @State private var priceText = ""
    @State private var quantityText = "1"
    @State private var selectedCategory = "Groceries"
    @State private var showValidationAlert = false

    private let categories = [
        "Groceries",
        "Pharmacy",
        "Electronics",
        "Cleaning",
        "Other"
    ]

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(.systemGray6), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 22) {
                headerSection

                VStack(alignment: .leading, spacing: 18) {
                    Text("Item Information")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    formField(
                        title: "Item Name",
                        text: $itemName,
                        placeholder: "e.g. Eggs"
                    )

                    formField(
                        title: "Price",
                        text: $priceText,
                        placeholder: "e.g. 3.99"
                    )
                    .keyboardType(.decimalPad)

                    formField(
                        title: "Quantity",
                        text: $quantityText,
                        placeholder: "e.g. 1"
                    )
                    .keyboardType(.numberPad)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Category")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.black)

                        Picker("Category", selection: $selectedCategory) {
                            ForEach(categories, id: \.self) { category in
                                Text(category).tag(category)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(26)
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top)
        }
        .navigationBarBackButtonHidden(true)
        .alert("Invalid Input", isPresented: $showValidationAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please enter a valid item name, price, and quantity.")
        }
    }

    private var headerSection: some View {
        HStack {
            CircleButtonView(systemName: "chevron.left") {
                dismiss()
            }

            Spacer()

            VStack(spacing: 2) {
                Text("Add Item")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)

                Text("Create a new shopping item")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }

            Spacer()

            Button {
                saveItem()
            } label: {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 12)
                    .background(Color.black)
                    .cornerRadius(14)
            }
            .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
        }
        .padding(.horizontal)
    }

    private func formField(title: String, text: Binding<String>, placeholder: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.black)

            TextField(placeholder, text: text)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
        }
    }

    private func saveItem() {
        let trimmedName = itemName.trimmingCharacters(in: .whitespacesAndNewlines)

        guard
            !trimmedName.isEmpty,
            let price = Double(priceText),
            let quantity = Int(quantityText),
            quantity > 0,
            price >= 0
        else {
            showValidationAlert = true
            return
        }

        let newItem = CartItem(
            name: trimmedName,
            price: price,
            quantity: quantity,
            category: selectedCategory
        )

        list.items.append(newItem)

        dismiss()
    }
}

#Preview {
    NavigationStack {
        AddItemView(list: ShoppingList(name: "Groceries"))
    }
}
