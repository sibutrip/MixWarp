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
        pd?.configureAmbient(withSampleRate: 48000, outputChannels: 2)
        pd?.isActive = true
    }
}

class Patch: ObservableObject {
    var isActive = false
    var patch = PDPatch(file: "test.pd")
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
    
    func toggleIsGoofy(instanceNumber: Float) {
        goofyDict[instanceNumber]?.toggle()
        let isGoofyToggleFloat = dictToFloat(dict: goofyDict, key: instanceNumber)
        print("(\(Int(instanceNumber)),\(String(isGoofyToggleFloat)))")
        patch?.instanceIsGoofy(instanceNumber, toggle: isGoofyToggleFloat)
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
    @StateObject var patch = Patch()
    
    var body: some View {
        VStack {
            HStack {
                Text("on/off")
                ForEach(1..<6, id: \.self) { instance in
                    Button {
                        patch.toggleInstance(instanceNumber: Float(instance))
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.mint)
                            .frame(width: 50, height: 50)
                            .overlay {
                                Text(patch.instanceDict[Float(instance)] ?? true ? "X" : "")
                                    .foregroundColor(.black)
                            }
                    }
                }
            }
            HStack {
                Text("goofy\ntoggle")
                ForEach(1..<6, id: \.self) { instance in
                    Button {
                        patch.toggleIsGoofy(instanceNumber: Float(instance))
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.mint)
                            .frame(width: 50, height: 50)
                            .overlay {
                                Text(patch.goofyDict[Float(instance)] ?? true ? "X" : "")
                                    .foregroundColor(.black)
                            }
                    }
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
