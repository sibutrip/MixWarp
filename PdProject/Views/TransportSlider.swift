//
//  TransportSlider.swift
//  PdProject
//
//  Created by Cory Tripathy on 12/22/22.
//

import SwiftUI

enum ChevronStyle: String {
    case starting = "arrowtriangle.right.fill"
    case ending = "arrowtriangle.left.fill"
}

struct TransportSlider: View {
    @Binding var startValue: Float
    @Binding var endValue: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 9)
                    .stroke(lineWidth: 5)
                    .frame(height: 50)
                    .padding(geometry.size.width / 15)
                TransportChevron(value: $startValue, pairValue: $endValue, chevronStyle: .starting)
                    .padding(geometry.size.width / 30)
                TransportChevron(value: $endValue, pairValue: $startValue, chevronStyle: .ending)
                    .padding(geometry.size.width / 30)
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
        .padding(10)
    }
}

struct TransportChevron: View {
    @Binding var value: Float
    @Binding var pairValue: Float
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
    
    var chevronCircleColor: Color {
        if isDragging {
            return .red
        } else {
            return .primary
        }
    }
    
    var chevronStyle: ChevronStyle
    
    var body: some View {
        GeometryReader { geometry in
            Image(systemName: chevronStyle.rawValue)
                .resizable()
                .frame(width: 30, height: 80)
                .foregroundColor(isDragging ? .red : .primary)
            //                .foregroundStyle(Color("background"), chevronCircleColor)
                .offset(x: CGFloat((rangeMid - value) / (rangeMax - rangeMin)) * geometry.size.width)
                .gesture(SimultaneousGesture(
                    DragGesture(minimumDistance: 0.0)
                        .onChanged({ newValue in
                            if isDragging == false {
                                isDragging = true
                            }
                            var difference: CGFloat {
                                switch chevronStyle {
                                case .starting:
                                    return newValue.location.x - geometry.size.width / 11.5
                                case .ending:
                                    return newValue.location.x
                                }
                            }
                            
                            let scaledDifference = difference / geometry.size.width * CGFloat(rangeDifference)
                            
                            var displayedValue = rangeMid - Float(scaledDifference)
                            var newValue = Float()
                            switch chevronStyle {
                            case .starting:
                                if displayedValue < rangeMax * 1 / 15 {
                                    displayedValue = rangeMax * 1 / 15
                                }
                                else if displayedValue > rangeMax {
                                    displayedValue = rangeMax
                                }
                                newValue = (displayedValue - rangeMax) / 14
                                
                            case .ending:
                                if displayedValue < rangeMin {
                                    displayedValue = rangeMin
                                }
                                else if displayedValue > rangeMax * 14 / 15 {
                                    displayedValue = rangeMax * 14 / 15
                                }
                                newValue = displayedValue * 15/14
                            }
                            newValue = (newValue * -1) + 1
                            value = displayedValue
                            
                            print(value)
                            print(pairValue)
                            
                        })
                        .onEnded({ newValue in
                            isDragging = false
                        }), TapGesture(count: 2)
                        .onEnded({ _ in
                            switch chevronStyle {
                            case .starting:
                                value = 1
                            case .ending:
                                value = 0
                            }
                        }))
                )
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
}

struct TransportSlider_Previews_Controller: View {
    @State private var startValue: Float = 1.0
    @State private var endValue: Float = 0.0
    
    var body: some View {
        TransportSlider(startValue: $startValue, endValue: $endValue)
    }
}

struct TransportSlider_Previews: PreviewProvider {
    static var previews: some View {
        TransportSlider_Previews_Controller()
    }
}
