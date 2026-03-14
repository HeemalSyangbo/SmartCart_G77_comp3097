

import SwiftUI
import SwiftData

@main
struct SmartCartApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [ShoppingList.self, CartItem.self])
    }
}
