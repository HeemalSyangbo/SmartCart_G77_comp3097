

import Foundation
import SwiftData

@Model
final class CartItem {
    var name: String
    var price: Double
    var quantity: Int
    var category: String
    var createdAt: Date

    init(name: String, price: Double, quantity: Int, category: String, createdAt: Date = Date()) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.category = category
        self.createdAt = createdAt
    }
}
