//
//  ContentView.swift
//  PdiOSTest
//
//  Created by Cory Tripathy on 12/5/22.
//

import SwiftUI
import libpd

struct ContentView: View {
    var pd = PdEngine()
    @StateObject var vm = ViewModel()
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            Text("Start Position")
                                .font(.headline)

                            Text("\(vm.faderLoopStart, specifier: "%.2f")")
                            Fader(value: $vm.faderLoopStart)
                                .frame(height: 150.0)
                        }
                        VStack {
                            Text("Loop Length")
                                .font(.headline)
                            Text("\(vm.faderLoopEnd, specifier: "%.2f")")
                            Fader(value: $vm.faderLoopEnd)
                                .frame(height: 150.0)
                        }
                        Spacer()
                    }
                    Spacer()
                    HStack(spacing: 0) {
    //                    Spacer()
                        Record(isOn: $vm.toggleRecord)
                            .animation(nil, value: vm.toggleRecord)
                            .frame(width: geo.size.width / 3.0)
                        Play(isOn: $vm.toggleLoop)
                            .animation(nil, value: vm.toggleLoop)
                            .frame(width: geo.size.width / 3.0)
                        VStack {
                            Text("Loop Speed")
                                .font(.headline)
                            Text("\(vm.faderSpeedFader, specifier: "%.2f")")
                            Fader(value: $vm.faderSpeedFader, range: -5...5)
                                .frame(height: 150.0)
                            
                        }.onTapGesture(count: 2) {
                            vm.faderSpeedFader = Float(1)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .navigationTitle("MixWarp")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
