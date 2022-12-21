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
                    Text("loop start")
                    Text("\(vm.faderLoopStart)")
                    Fader(value: $vm.faderLoopStart)
                        .frame(height: 150.0)
                }
                VStack {
                    Text("loop end")
                    Text("\(vm.faderLoopEnd)")
                    Fader(value: $vm.faderLoopEnd)
                        .frame(height: 150.0)
                }
                Spacer()
            }
            HStack {
                Spacer()
                VStack {
                    Text("Record is \(vm.toggleRecord ? "ON" : "off")")
                        .frame(width: 120)
                    Bang(isOn: $vm.toggleRecord)
                }
                VStack {
                    Text("Loop is \(vm.toggleLoop ? "ON" : "off")")
                        .frame(width: 120)
                    Bang(isOn: $vm.toggleLoop)
                }
                VStack {
                    Text("\(vm.faderSpeedFader)")
                    Fader(value: $vm.faderSpeedFader)
                        .frame(height: 150.0)
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
