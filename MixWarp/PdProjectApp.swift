//
//  PdProjectApp.swift
//  PdProject
//
//  Created by Cory Tripathy on 12/8/22.
//

import SwiftUI

@main
struct PdProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(OrientationInfo())
        }
    }
}
