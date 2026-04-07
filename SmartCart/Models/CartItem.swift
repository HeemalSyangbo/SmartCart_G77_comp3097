//
//  CartItem.swift
//  SmartCart
//
//  Author: Heemal Syangbo - 101532464
//  Edited by:
//  - Anudhin Thomas - 101516423
//    Changes: UI/data integration support
//  - Jeffin Yohannan - 101512594
//    Changes: Shopping item structure review
//
//  Description:
//  This model stores a single shopping item inside a shopping list.
//  It includes item name, price, quantity, category, and created date.
//

import Foundation
import SwiftData

@Model
final class CartItem {
    var name: String
    var price: Double
    var quantity: Int
    var category: String
    var createdAt: Date

    init(
        name: String,
        price: Double,
        quantity: Int,
        category: String,
        createdAt: Date = Date()
    ) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.category = category
        self.createdAt = createdAt
    }

    // Total cost for this item = price × quantity
    var totalPrice: Double {
        price * Double(quantity)
    }
}
