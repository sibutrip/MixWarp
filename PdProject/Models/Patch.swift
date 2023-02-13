//
//  Patch.swift
//  PdProject
//
//  Created by Cory Tripathy on 12/21/22.
//

import Foundation

class Patch: ObservableObject {
    var patch = PDPatch(file: "audioTest.pd")
    
    func toggleRecord(onOff: Bool) {
        let onOffFloat: Float = onOff ? 1 : 0
        patch?.toggleRecord(onOffFloat)
    }
    
    func toggleLoop(onOff: Bool) {
        let onOffFloat: Float = onOff ? 1 : 0
        patch?.toggleLoop(onOffFloat)
    }
    
    func floatLoopStart(floatValue: Float) {
        patch?.floatLoopStart(floatValue)
    }
    
    func floatLoopEnd(floatValue: Float) {
        patch?.floatLoopEnd(floatValue)
    }
    
    func floatSpeedFader(floatValue: Float) {
        patch?.floatSpeedFader(floatValue)
    }
    
    func sendBangToRecord() {
        patch?.sendBangToRecord()
    }
    
    func sendBangToLoop() {
        patch?.sendBangToLoop()
    }
    
    func floatTransportSliderStart(floatValue: Float) {
        patch?.floatTransportSliderStart(floatValue)
    }
    
    func floatTransportSliderEnd(floatValue: Float) {
        patch?.floatTransportSliderEnd(floatValue)
    }
    
    func floatDelayTime(floatValue: Float) {
        patch?.floatDelayTime(floatValue)
    }
    
    func floatDelayAmount(floatValue: Float) {
        patch?.floatDelayAmount(floatValue)
    }
}
