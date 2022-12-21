//
//  PdEngine.swift
//  PdProject
//
//  Created by Cory Tripathy on 12/21/22.
//

import Foundation

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
