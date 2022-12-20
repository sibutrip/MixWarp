//
//  ViewModel.swift
//  MaxComponentsSwiftUI
//
//  Created by Zoe Cutler on 12/16/22.
//

import Foundation

class ViewModel: ObservableObject {
    var patch = Patch()
    @Published var bang1IsOn: Bool = false {
        didSet {
            patch.toggleRecord(onOff: bang1IsOn)
//            patch.sendBangToRecord()
            if bang1IsOn == true {
                //TODO: send bang on to PD
                //REQUIRED
            } else {
                //TODO: send bang off to PD
                //if we don't care about the off control, don't do anything here
            }
        }
    }
    @Published var bang2IsOn: Bool = false {
        didSet {
            patch.toggleLoop(onOff: bang2IsOn)
//            patch.sendBangToLoop()
            if bang1IsOn == true {
                //TODO: send bang on to PD
                //REQUIRED
            } else {
                //TODO: send bang off to PD
                //if we don't care about the off control, don't do anything here
            }
        }
    }
    
    @Published var fader1Value: Float = 0.0 {
        didSet {
            patch.floatFader(floatValue: fader1Value)
            //TODO: send fader1Value to PD
        }
    }
}
