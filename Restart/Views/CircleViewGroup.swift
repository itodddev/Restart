//
//  CircleViewGroup.swift
//  Restart
//
//  Created by Todd James on 6/30/22.
//

import SwiftUI

struct CircleViewGroup: View {

  @State var ShapeColor: Color
  @State var ShapeOpacity: Double
  @State private var isAnimating: Bool = false

  var body: some View {
    ZStack {
      Circle() // Back Image
        .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
        .frame(width: 260, height: 260, alignment: .center)
      Circle() // Top Image, band darker where circles overlap
        .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80)
        .frame(width: 260, height: 260, alignment: .center)
    } //: ZSTACK
    .blur(radius: isAnimating ? 0 : 10)
    .opacity(isAnimating ? 1 : 0)
    .scaleEffect(isAnimating ? 1 : 0.5)
    .animation(.easeOut(duration: 1), value: isAnimating)
    .onAppear(perform: {
      isAnimating = true
    })
  }
}

struct CircleViewGroup_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color("ColorBlue")
        .ignoresSafeArea(.all, edges: .all)
      CircleViewGroup(ShapeColor: .white, ShapeOpacity: 0.2)
    }
  }
}
