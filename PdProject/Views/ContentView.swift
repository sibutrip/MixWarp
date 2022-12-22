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
        VStack {
            HStack {
                Spacer()
                VStack {
                    Text("Start Position")
                    Text("\(vm.faderLoopStart)")
                    Fader(value: $vm.faderLoopStart)
                        .frame(height: 150.0)
                }
                VStack {
                    Text("End Position")
                    Text("\(vm.faderLoopEnd)")
                    Fader(value: $vm.faderLoopEnd)
                        .frame(height: 150.0)
                }
                Spacer()
            }
            HStack {
                Spacer()
                Record(isOn: $vm.toggleRecord)
                    .animation(nil, value: vm.toggleRecord)
                    .frame(width: 120)
                Play(isOn: $vm.toggleLoop)
                    .animation(nil, value: vm.toggleLoop)
                    .frame(width: 120)
                VStack {
                    Text("Loop Speed")
                    Text("\(vm.faderSpeedFader)")
                    Fader(value: $vm.faderSpeedFader, range: -5...5)
                        .frame(height: 150.0)
                }.onTapGesture(count: 2) {
                    vm.faderSpeedFader = Float(1)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
