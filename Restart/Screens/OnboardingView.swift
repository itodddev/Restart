//
//  OnboardingView.swift
//  Restart
//
//  Created by Todd James on 6/30/22.
//

import SwiftUI

struct OnboardingView: View {
  @AppStorage("onboarding") var isOnboardingViewActive: Bool = true // This true value will only be added to the property when the program does not find a "onboarding" key previously set in the devices permanent storage.  If it finds a previously created "onboarding" key it will skip this initialization value

  @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
  @State private var buttonOffset: CGFloat = 0
  @State private var isAnimating: Bool = false

  var body: some View {
    ZStack {
      Color("ColorBlue") // Background
        .ignoresSafeArea(.all, edges: .all)

      VStack(spacing: 20) { // Vertical spacing between components
        // MARK: - HEADER

        Spacer()
        VStack(spacing: 0) {
          Text("Share.")
            .font(.system(size: 60))
            .fontWeight(.heavy)
            .foregroundColor(.white)

          // Multiline subheader
          Text("""
          It's not how much we give but
          how much love we put into giving.
          """)
          .font(.title3)
          .fontWeight(.light)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 10)
        } //: HEADER
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : -40) // neg down from top, pos up from bottom
        .animation(.easeOut(duration: 1), value: isAnimating) // value is whats changing to start animation

        // MARK: - CENTER
        ZStack {
          CircleViewGroup(ShapeColor: .white, ShapeOpacity: 0.2)

          Image("character-1")
            .resizable()
            .scaledToFit()
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeOut(duration: 0.5), value: isAnimating)
        } //: CENTER
        Spacer() // pushes up content from the bottom

        // MARK: - FOOTER
        ZStack {
          // Part of the custom button
          // 1. Background (Static)
          Capsule()
            .fill(Color.white.opacity(0.2))

          Capsule()
            .fill(Color.white.opacity(0.2))
            .padding(8)

          // 2. Call-to-Action (Static)
          Text("Get Started")
            .font(.system(.title3, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .offset(x: 20) // move to right

          // 3. Capsule (Dynamic Width)
          HStack {
            Capsule()
              .fill(Color("ColorRed"))
              .frame(width: buttonOffset + 80) // expands the background with drag

            Spacer() // push circle to left edge
          }

          // 4. Circle (Draggable)
          HStack {
            ZStack {
              Capsule()
                .fill(Color("ColorRed"))
              Capsule()
                .fill(.black.opacity(0.15))
                .padding(8)

              Image(systemName: "chevron.right.2")
                .font(.system(size: 24, weight: .bold))
            }
            .foregroundColor(.white)
            .frame(width: 80, height: 80, alignment: .center)
            .offset(x: buttonOffset)
            .gesture(
              DragGesture()
                .onChanged { gesture in
                  if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                    buttonOffset = gesture.translation.width
                  }
                }
                .onEnded { _ in // when dragging stops in middle snap back to beginning
                  withAnimation(Animation.easeOut(duration: 0.4)) { // transition between screens
                    if buttonOffset > buttonWidth / 2 {  // cuts button width in half, if after midway on right go back to home view, else go start of button
                      buttonOffset = buttonWidth - 80
                      isOnboardingViewActive = false // go to home screen
                    } else {
                      buttonOffset = 0
                    }
                  }
                }
            ) //: Gesture

            Spacer() // push circle button to the left
          } //: HSTACK
        } //: FOOTER
        .frame(width: buttonWidth, height: 80, alignment: .center) // height fixed, buttonWidth is dynamic computed prop
        .padding() // add space around button
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : 40)
        .animation(.easeOut(duration: 1), value: isAnimating)
      } //: VSTACK
    } //: ZSTACK
    .onAppear(perform: {
      isAnimating = true
    })
  } //: BODY
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
  }
}
