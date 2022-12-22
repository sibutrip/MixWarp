//
//  PdEngine.swift
//  PdProject
//
//  Created by Cory Tripathy on 12/21/22.
//

import Foundation
import libpd

class PdEngine {
    var pd:PdAudioController?
    init() {
        pd = PdAudioController()
        pd?.configurePlayback(withSampleRate: 48000, inputChannels: 2, outputChannels: 2, inputEnabled: true)
        pd?.isActive = true
    }
}
