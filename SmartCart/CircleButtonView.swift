import SwiftUI

struct CircleButtonView: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color(.systemGray5))
                    .frame(width: 54, height: 54)

                Image(systemName: systemName)
                    .font(.title2)
                    .foregroundColor(.black)
            }
        }
    }
}
