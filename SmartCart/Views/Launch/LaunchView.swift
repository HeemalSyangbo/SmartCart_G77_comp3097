//
//  LaunchView.swift
//  SmartCart
//
//  Author: Heemal Syangbo - 101532464
//  Edited by:
//  - Anudhin Thomas - 101516423
//    Changes: Launch screen layout alignment
//  - Jeffin Yohannan - 101512594
//    Changes: UI text/content review
//
//  Description:
//  This is the first screen shown when the app opens.
//  It displays the app title, group information, and a button to enter the app.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.black, Color.black.opacity(0.92)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    VStack(spacing: 10) {
                        Text("SmartCart")
                            .font(.system(size: 42, weight: .heavy))
                            .foregroundColor(.white)

                        Text("Shopping List & Tax Calculator")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                    }

                    VStack(spacing: 8) {
                        Text("Group 77")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.9))

                        Text("COMP 3097")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.8))
                    }

                    VStack(spacing: 6) {
                        Text("Anudhin Thomas")
                        Text("Heemal Syangbo")
                        Text("Jeffin Yohannan")
                    }
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.72))
                    .padding(.top, 6)

                    Spacer()

                    NavigationLink(destination: HomeView()) {
                        Text("Enter App")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: 200)
                            .padding(.vertical, 15)
                            .background(Color.white)
                            .cornerRadius(14)
                    }

                    Spacer()
                        .frame(height: 60)
                }
                .padding(.horizontal, 24)
            }
        }
    }
}

#Preview {
    LaunchView()
}
