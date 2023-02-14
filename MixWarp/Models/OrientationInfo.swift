//
//  OrientationInfo.swift
//  MixWarp
//
//  Created by Cory Tripathy on 2/13/23.
//

import Foundation
import UIKit
import SwiftUI

final class OrientationInfo: ObservableObject {
    enum Orientation {
        case portrait
        case landscape
    }
    
    @Published var orientation = Orientation.portrait
    
    private var _observer: NSObjectProtocol?
    
    init() {
        if UIDevice.current.orientation.isLandscape {
            self.orientation = .landscape
        } else if UIDevice.current.orientation.isFlat {
            self.orientation = .portrait
        } else {
            self.orientation = .portrait
        }
        
        // unowned self because we unregister before self becomes invalid
        _observer = NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: nil) { [unowned self] note in
            guard let device = note.object as? UIDevice else {
                return
            }
            if device.orientation.isLandscape {
                self.orientation = .landscape
            }
            else if device.orientation.isPortrait {
                self.orientation = .portrait
            } else {
                self.orientation = .portrait
            }
        }
    }
    
    deinit {
        if let observer = _observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
