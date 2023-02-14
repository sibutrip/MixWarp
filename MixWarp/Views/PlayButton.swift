//
//  PlayButton.swift
//  PdProject
//
//  Created by Cory Tripathy on 12/21/22.
//

import SwiftUI

struct Play: View {
    @Binding var isOn: Bool
    @State var isTapped = false
    @State var imageName = "pause.fill"
    
    var body: some View {
        Image(systemName: imageName)
            .font(.system(size: isTapped ? 88 : 100))
            .onChange(of: isOn, perform: { newValue in
                imageName = newValue ? "play.fill" : "pause.fill"
            })
            .animation(.easeInOut(duration: 0.08), value: isTapped)
            .animation(nil, value: isOn)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0.0)
                    .onChanged({ _ in
                        withAnimation {
                            isTapped = true
                        }
                    })
                    .onEnded({ _ in
                        isOn.toggle()
                        imageName = isOn ? "play.fill" : "pause.fill"
                        withAnimation {
                            isTapped = false
                        }
                        
                    })
            )
            .foregroundColor(isOn ? .playButtonOn : .playRecordOff)
            .padding()
    }
}


//To help us dynamically preview our Play
struct Play_Previews_Controller: View {
    @State private var playIsOn: Bool = false
    
    var body: some View {
        Play(isOn: $playIsOn)
    }
}

struct Play_Previews: PreviewProvider {
    static var previews: some View {
        Play_Previews_Controller()
    }
}
