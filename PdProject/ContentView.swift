//
//  ContentView.swift
//  PdiOSTest
//
//  Created by Cory Tripathy on 12/5/22.
//

import SwiftUI
import libpd

class PdEngine {
    var pd:PdAudioController?
    func toggleEngine() {
        pd?.isActive = false
    }
    init() {
        pd = PdAudioController()
        pd?.configurePlayback(withSampleRate: 48000, inputChannels: 2, outputChannels: 2, inputEnabled: true)
        //        pd?.configureAmbient(withSampleRate: 48000, outputChannels: 2)
        pd?.isActive = true
    }
}

class Patch: ObservableObject {
    var isActive = false
    var patch = PDPatch(file: "audioTest.pd")
    var instanceNumber: Float = 1
    var toggleOnOff = false
    @Published var instanceDict = [Float: Bool]()
    @Published var goofyDict = [Float: Bool]()
    
    func dictToFloat(dict: [Float: Bool], key: Float) -> Float {
        guard let dict = dict[key] else {
            fatalError("could not locate dict value")
        }
        if dict {
            return Float(1)
        } else {
            return Float(0)
        }
    }
    
    func toggleInstance(instanceNumber: Float) {
        instanceDict[instanceNumber]?.toggle()
        let currentInstanceToggleFloat = dictToFloat(dict: instanceDict, key: instanceNumber)
        print("(\(Int(instanceNumber)),\(String(currentInstanceToggleFloat)))")
        patch?.instanceCount(instanceNumber, toggle: currentInstanceToggleFloat)
    }
    
    func toggleRecord(onOff: Bool) {
        let onOffFloat: Float = onOff ? 1 : 0
        print("toggle record")
        patch?.toggleRecord(onOffFloat)
    }
    
    func toggleLoop(onOff: Bool) {
        let onOffFloat: Float = onOff ? 1 : 0
        print("toggle loop")
        patch?.toggleLoop(onOffFloat)
    }
    
    func floatFader(floatValue: Float) {
        patch?.floatFader(floatValue)
    }
    
    func toggleIsGoofy(instanceNumber: Float) {
        goofyDict[instanceNumber]?.toggle()
        let isGoofyToggleFloat = dictToFloat(dict: goofyDict, key: instanceNumber)
        print("(\(Int(instanceNumber)),\(String(isGoofyToggleFloat)))")
        patch?.instanceIsGoofy(instanceNumber, toggle: isGoofyToggleFloat)
    }
    
//    func sendBang() {
//        patch?.sendBang()
//    }
    
    func sendBangToRecord() {
        patch?.sendBangToRecord()
    }
    
    func sendBangToLoop() {
        patch?.sendBangToLoop()
    }

    
    init() {
        for i in 1..<6 {
            instanceDict[Float(i)] = false
            goofyDict[Float(i)] = false
        }
    }
}

struct ContentView: View {
    var pd = PdEngine()
    @StateObject var vm = ViewModel()
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Bang(isOn: $vm.bang1IsOn)
                Text("Record is \(vm.bang1IsOn ? "ON" : "off")")
                    .frame(width: 120)
            }
            VStack {
                Bang(isOn: $vm.bang2IsOn)
                Text("Loop is \(vm.bang2IsOn ? "ON" : "off")")
                    .frame(width: 120)
            }
            VStack {
                Fader(value: $vm.fader1Value)
                    .frame(height: 150.0)
                Text("\(vm.fader1Value)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
