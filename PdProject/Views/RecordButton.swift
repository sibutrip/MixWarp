//
//  RecordButton.swift
//  PdProject
//
//  Created by Cory Tripathy on 12/21/22.
//

import SwiftUI

struct Record: View {
    @Binding var isOn: Bool
    @State var isTapped = false
    @State var imageName = "circle.fill"
    
    var body: some View {
        Image(systemName: imageName)
            .font(.system(size: isTapped ? 80 : 88))
            .animation(.easeInOut(duration: 0.08), value: isTapped)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0.0)
                    .onChanged({ _ in
                        withAnimation {
                            isTapped = true
                        }
                    })
                    .onEnded({ _ in
                        withAnimation {
                            isOn.toggle()
                            isTapped = false
                        }
                        
                    })
            )
            .foregroundColor(isOn ? .recordButtonOn : .playRecordOff)
    }
}


//To help us dynamically preview our Play
struct Record_Previews_Controller: View {
    @State private var recordIsOn: Bool = false
    
    var body: some View {
        Record(isOn: $recordIsOn)
    }
}

struct Record_Previews: PreviewProvider {
    static var previews: some View {
        Record_Previews_Controller()
    }
}
