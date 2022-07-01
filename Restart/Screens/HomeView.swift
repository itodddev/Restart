//
//  HomeView.swift
//  Restart
//
//  Created by Todd James on 6/30/22.
//

import SwiftUI

struct HomeView: View {
  @AppStorage("onboarding") var isOnboardingViewActive: Bool = false // We do not set value here, just for safety
  @State private var isAnimating: Bool = false

  var body: some View {
    VStack(spacing: 20) {
      // MARK: HEADER

      Spacer()

      ZStack {
        CircleViewGroup(ShapeColor: .gray, ShapeOpacity: 0.1) // reuseable view in Views/CircleViewGroup

        Image("character-2")
          .resizable()
          .scaledToFit()
          .padding()
          .offset(y: isAnimating ? 35 : -35)
          .animation(
            Animation
              .easeInOut(duration: 4)
              .repeatForever()
            , value: isAnimating)
          .onAppear(perform: {
            isAnimating = true
          })
      }

      // MARK: CENTER

      Text("The time that leads to mastery is dependent on the intensity of our focus.")
        .font(.title3)
        .fontWeight(.light)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
        .padding()

      // MARK: FOOTER

      Spacer()

      Button(action: {
        isOnboardingViewActive = true
      }) {
        // If there are 2 views in a button lable, it automatically renders an HStack
        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
          .imageScale(.large)
        Text("Restart")
          .font(.system(.title3, design: .rounded))
          .fontWeight(.bold)
      }
      .buttonStyle(.borderedProminent)
      .buttonBorderShape(.capsule)
      .controlSize(.large)

    } //: VSTACK
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
