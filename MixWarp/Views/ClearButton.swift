//
//  ClearButton.swift
//  MixWarp
//
//  Created by Cory Tripathy on 2/14/23.
//

import SwiftUI

struct ClearButton: View {
    @State var isTapped = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(LinearGradient(colors: [.faderBackground,.faderBackgroundBlend,.faderBackground], startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 1.0, y: 0.0)))
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(LinearGradient(colors: [.faderBackground,.faderBackgroundBlend,.faderBackground], startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 0.0, y: 1.0)))
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray2)
            }
            .opacity(0.5)
                .blendMode(.multiply)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .overlay(alignment: .center) {
            Text("Clear Delay")
                .font(isTapped ? .title2 : .title3)
                .animation(.easeInOut(duration: 0.08), value: isTapped)
        }
        .gesture(
            DragGesture(minimumDistance: 0.0)
                .onChanged({ _ in
                    withAnimation {
                        isTapped = true
                    }
                })
                .onEnded({ _ in
                    isTapped = false
                })
        )
        .padding(.top)
    }
}

struct ClearButton_Previews: PreviewProvider {
    static var previews: some View {
        ClearButton()
    }
}
