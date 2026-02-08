import SwiftUI

struct LaunchView: View {
    var body: some View {
        VStack(spacing: 18) {
            Spacer()

            Text("SmartCart")
                .font(.system(size: 44, weight: .bold))

            Text("Group 77")
                .font(.headline)
                .foregroundStyle(.secondary)

            Text("COMP 3097")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()

            NavigationLink {
                HomeView()
            } label: {
                Text("Enter App")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal, 24)
            }

            Spacer().frame(height: 24)
        }
    }
}

#Preview {
    NavigationStack {
        LaunchView()
    }
}
