//
//  ContentView.swift
//  PdiOSTest
//
//  Created by Cory Tripathy on 12/5/22.
//

import SwiftUI
import libpd

struct ContentView: View {
    @EnvironmentObject var orientationInfo: OrientationInfo
    
    @StateObject var vm = ViewModel()
    
    var body: some View {
        if orientationInfo.orientation == .portrait {
            portraitView
        } else {
            landscapeView
        }
    }
}


extension ContentView {
    var portraitView: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    startPosition
                    loopLength
                    loopSpeed
                    Spacer()
                }
                Spacer()
                Spacer()
                HStack(spacing: 0) {
                    Spacer()
                    Record(isOn: $vm.toggleRecord)
                        .animation(nil, value: vm.toggleRecord)
                        .frame(width: geo.size.width / 3.0)
                    Play(isOn: $vm.toggleLoop)
                        .animation(nil, value: vm.toggleLoop)
                        .frame(width: geo.size.width / 3.0)
                    Spacer()
                }
                .frame(height: geo.size.height / 6.5)
                Spacer()
                HStack {
                    Spacer()
                        .frame(width: geo.size.width / 5.5)
                    VStack {
                        HStack {
                            delayTime
                            delayAmount
                        }
                        .padding(.bottom)
                        ClearButton(isTapped: $vm.clearDelay)
                    }
                    Spacer()
                        .frame(width: geo.size.width / 5.5)
                }
                Spacer()
                Spacer()
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .navigationTitle("M i x W a r p")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
    var landscapeView: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                Spacer()
                HStack {
                    startPosition
                    loopLength
                    loopSpeed
                    delayTime
                    delayAmount
                }
                .padding(.bottom, 30)
                HStack {
                    Group {
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        
                        Record(isOn: $vm.toggleRecord)
                            .animation(nil, value: vm.toggleRecord)
                        //                            .frame(width: geo.size.width / 3.0)
                        Spacer()
                        Spacer()
                        
                        Spacer()
                    }
                    Group {

                        Play(isOn: $vm.toggleLoop)
                            .animation(nil, value: vm.toggleLoop)
//                            .frame(width: geo.size.width / 3.0)
                        Spacer()
                        
                    
                    
                   
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        ClearButton(isTapped: $vm.clearDelay)
                            .frame(width: geo.size.width / 3)
                   
                        
                        Spacer()
                    }
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .navigationTitle("M i x W a r p")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var startPosition: some View {
        VStack(spacing: 3) {
            Text("Start Position")
                .font(.headline)
            if vm.faderLoopStart == 0 {
                Text("Start")
            } else if vm.faderLoopStart == 1 {
                Text("End")
                
            }
            else {
                Text("\(vm.faderLoopStart, specifier: "%.2f")")
            }
            Fader(value: $vm.faderLoopStart)
                .frame(height: 150.0)
        }
    }
    
    var loopLength: some View {
        VStack(spacing: 3) {
            Text("Loop Length")
                .font(.headline)
            if vm.faderLoopEnd == 0 {
                Text("Min")
            } else if vm.faderLoopEnd == 1 {
                Text("Max")
            } else {
                Text("\(vm.faderLoopEnd, specifier: "%.2f")")
            }
            Fader(value: $vm.faderLoopEnd)
                .frame(height: 150.0)
        }
    }
    
    var loopSpeed: some View {
        VStack(spacing: 3) {
            Text("Loop Speed")
                .font(.headline)
            Text("\(vm.faderSpeedFader, specifier: "%.2f")x")
            Fader(value: $vm.faderSpeedFader, range: -5...5)
                .frame(height: 150.0)
            
        }
        .onTapGesture(count: 2) {
            vm.faderSpeedFader = Float(1)
        }
    }
    
    var delayTime: some View {
        VStack(spacing: 3) {
            Text("Delay Time")
                .font(.headline)
            Text("\(vm.delayTime, specifier: "%.2f")s")
            Fader(value: $vm.delayTime, range: 0...5)
                .frame(height: 150.0)
            
        }
    }
    
    var delayAmount: some View {
        VStack(spacing: 3) {
            Text("Delay Amount")
                .font(.headline)
            Text("\(vm.delayAmount * 100, specifier: "%.0f")%")
            Fader(value: $vm.delayAmount, range: 0...1)
                .frame(height: 150.0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(OrientationInfo())
    }
}
