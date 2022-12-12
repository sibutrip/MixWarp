//
//  ContentView.swift
//  PdProject
//
//  Created by Cory Tripathy on 12/8/22.
//

import SwiftUI
import libpd

class PDController {
    let pd = PdAudioController()
    init() {
        pd?.configureAmbient(withSampleRate: 48000, outputChannels: 2)
        pd?.isActive = true
    }
}

class Patch {
    var patch = PDPatch()
    var instanceDict = [Float: Bool]()
    init() {
        for num in 1...5 {
            instanceDict[Float(num)] = false
        }
    }
    
    func boolToFloat(for bool: Bool?) -> Float {
        guard let bool = bool else { fatalError() }
        if bool {
            return Float(1)
        } else {
            return Float(0)
        }
    }
    func toggleInstance(instance: Float) {
        instanceDict[instance]?.toggle()
        let boolAsFloat = boolToFloat(for: instanceDict[instance])
        print("\(instance),\(boolAsFloat)")
        patch.instanceCount(instance, toggle: boolAsFloat)
    }
    
    
}

struct ContentView: View {
    var patch = Patch()
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.mint)
            .overlay {
                Text("x")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
