//
//  ViewModel.swift
//  MaxComponentsSwiftUI
//
//  Created by Zoe Cutler on 12/16/22.
//

import Foundation

class ViewModel: ObservableObject {
    var patch = Patch()
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
    
    @Published var faderLoopEnd: Float = 0.0 {
        didSet {
            patch.floatLoopEnd(floatValue: faderLoopEnd)
        }
    }
    @Published var faderSpeedFader: Float = 0.0 {
        didSet {
            patch.floatSpeedFader(floatValue: faderSpeedFader)
        }
    }
}
