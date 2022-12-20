//
//  Slider.swift
//  MaxComponentsSwiftUI
//
//  Created by Zoe Cutler on 12/16/22.
//

import SwiftUI

struct Fader: View {
    @Binding var value: Float
    @State private var isDragging: Bool = false
    
    var range: ClosedRange<Float> = 0.0...1.0
    
    private var rangeMin: Float {
        range.lowerBound
    }
    
    private var rangeMid: Float {
        (range.upperBound + range.lowerBound) / 2
    }
    
    private var rangeMax: Float {
        range.upperBound
    }
    
    private var rangeDifference: Float {
        range.upperBound - range.lowerBound
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Rectangle()
                    .frame(width: 5.0)
                RoundedRectangle(cornerRadius: 5.0)
                    .foregroundColor(isDragging ? .red : .primary)
                    .frame(width: 60.0)
                    .frame(height: 20.0)
                    .offset(y: CGFloat((rangeMid - value) / (rangeMax - rangeMin)) * geometry.size.height)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0.0)
                    .onChanged({ newValue in
                        if isDragging == false {
                            isDragging = true
                        }
                        
                        let difference = newValue.location.y
                        
                        let scaledDifference = difference / geometry.size.height * CGFloat(rangeDifference)
                        
                        var newValue = rangeMax - Float(scaledDifference)
                        
                        if newValue > rangeMax {
                            newValue = rangeMax
                        }
                        
                        if newValue < rangeMin {
                            newValue = rangeMin
                        }
                        
                        value = newValue
                    })
                    .onEnded({ newValue in
                        isDragging = false
                    })
            )
        }
    }
}

//To help us dynamically preview our Bang
struct Fader_Previews_Controller: View {
    @State private var value: Float = 0.5
    
    var body: some View {
        Fader(value: $value)
    }
}


struct Fader_Previews: PreviewProvider {
    static var previews: some View {
        Fader_Previews_Controller()
    }
}
