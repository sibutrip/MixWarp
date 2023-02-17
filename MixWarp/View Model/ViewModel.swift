//
//  ViewModel.swift
//  MaxComponentsSwiftUI
//
//  Created by Zoe Cutler on 12/16/22.
//

import Foundation

class ViewModel: ObservableObject {
    var patch = Patch()
    
    var pd = PdEngine()

    @Published var toggleRecord: Bool = false {
        willSet {
            if self.toggleLoop {
                self.toggleLoop = false
            }
        }
        didSet {
            patch.toggleRecord(onOff: toggleRecord)
        }
    }
    @Published var toggleLoop: Bool = false {
        willSet {
            if self.toggleRecord {
                self.toggleRecord = false
            }
        }
        didSet {
            patch.toggleLoop(onOff: toggleLoop)
        }
    }
    
    @Published var faderLoopStart: Float = 0.0 {
        didSet {
            patch.floatLoopStart(floatValue: faderLoopStart)
        }
    }
    
    @Published var faderLoopEnd: Float = 1.0 {
        didSet {
            patch.floatLoopEnd(floatValue: faderLoopEnd)
        }
    }
    @Published var faderSpeedFader: Float = 1.0 {
        didSet {
            patch.floatSpeedFader(floatValue: faderSpeedFader)
        }
    }
    @Published var transportSliderStart: Float = 1  {
        didSet {
            var sliderStart = (transportSliderStart - 1 / 15) * 15 / 14
            sliderStart = (sliderStart * -1) + 1
            print(sliderStart)
            patch.floatTransportSliderStart(floatValue: sliderStart)
        }
    }
    @Published var transportSliderEnd: Float = 0 {
        didSet {
            var sliderEnd = transportSliderEnd * 15/14
            sliderEnd = (sliderEnd * -1) + 1
            print(sliderEnd)
            patch.floatTransportSliderEnd(floatValue: sliderEnd)
        }
    }
    
    @Published var delayTime: Float = 0 {
        didSet {
            patch.floatDelayTime(floatValue: delayTime)
        }
    }
    
    @Published var delayAmount: Float = 0 {
        didSet {
            patch.floatDelayAmount(floatValue: delayAmount)
        }
    }
    
    @Published var clearDelay: Bool = false{
        didSet {
            if clearDelay {
                patch.bangClearDelay()
            }
        }
    }
}
