//
//  ShoppingList.swift
//  SmartCart
//
//  Author: Heemal Syangbo - 101532464
//  Edited by:
//  - Anudhin Thomas - 101516423
//    Changes: List structure and screen flow alignment
//  - Jeffin Yohannan - 101512594
//    Changes: Tax calculator logic review
//
//  Description:
//  This model stores one shopping list and its related cart items.
//  It also provides computed values for subtotal, tax, and final total.
//

import Foundation
import SwiftData

@Model
final class ShoppingList {
    var name: String
    var createdAt: Date

    @Relationship(deleteRule: .cascade)
    var items: [CartItem]

    init(
        name: String,
        createdAt: Date = Date(),
        items: [CartItem] = []
    ) {
        self.name = name
        self.createdAt = createdAt
        self.items = items
    }

    // Items sorted by oldest first for consistent display
    var sortedItems: [CartItem] {
        items.sorted { $0.createdAt < $1.createdAt }
    }

    // Sum of all item totals before tax
    var subtotal: Double {
        items.reduce(0) { $0 + $1.totalPrice }
    }

    // Fixed 13% tax
    var taxAmount: Double {
        subtotal * 0.13
    }

    // Final total including tax
    var finalTotal: Double {
        subtotal + taxAmount
    }
}
