//
//  Bang.swift
//  MaxComponentsSwiftUI
//
//  Created by Zoe Cutler on 12/16/22.
//

import SwiftUI

struct Bang: View {
    @Binding var isOn: Bool
    var bangSize: BangSize = .small
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10.0)
            .overlay {
                Circle()
                    .stroke(lineWidth: 4)
                    .colorInvert()
                    .padding(5)
            }
            .overlay {
                if isOn {
                    Circle()
                        .colorInvert()
                        .padding(11)
                }
            }
            .modifier(BangFrameSize(bangSize: bangSize))
            .simultaneousGesture(
                DragGesture(minimumDistance: 0.0)
                    .onChanged({ _ in
                        if !isOn {
                            isOn = true
                        }
                    })
                    .onEnded({ _ in
                        isOn = false
                    })
            )
    }
}

enum BangSize {
    case small, medium, infinite
}

struct BangFrameSize: ViewModifier {
    var bangSize: BangSize
    
    func body(content: Content) -> some View {
            switch bangSize {
            case .small:
                content
                    .frame(width: 60.0, height: 60.0)
            case .medium:
                content
                    .frame(width: 95.0, height: 95.0)
            case .infinite:
                GeometryReader { geometry in
                    ZStack(alignment: .center) {
                        content
                            .frame(width:
                                    geometry.size.width < geometry.size.height ?
                                   geometry.size.width : geometry.size.height,
                                   height:
                                    geometry.size.width < geometry.size.height ?
                                   geometry.size.width : geometry.size.height)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }
    }
}

//To help us dynamically preview our Bang
struct Bang_Previews_Controller: View {
    @State private var bangIsOn: Bool = false
    
    var body: some View {
        Bang(isOn: $bangIsOn)
    }
}

struct Bang_Previews: PreviewProvider {
    static var previews: some View {
        Bang_Previews_Controller()
    }
}
