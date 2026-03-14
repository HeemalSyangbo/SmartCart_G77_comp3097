

import Foundation
import SwiftData

@Model
final class ShoppingList {
    var name: String
    var createdAt: Date
    @Relationship(deleteRule: .cascade) var items: [CartItem]

    init(name: String, createdAt: Date = Date(), items: [CartItem] = []) {
        self.name = name
        self.createdAt = createdAt
        self.items = items
    }
}
