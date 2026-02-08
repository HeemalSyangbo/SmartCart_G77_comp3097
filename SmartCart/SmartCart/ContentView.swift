import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            LaunchView()
                .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
