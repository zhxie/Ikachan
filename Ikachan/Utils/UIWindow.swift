//
//  UIWindow.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/1.
//

import Foundation
import SwiftUI

extension NSNotification.Name {
    public static let deviceDoShakeNotification = NSNotification.Name("MyDeviceDoShakeNotification")
    public static let deviceDidShakeNotification = NSNotification.Name("MyDeviceDidShakeNotification")
}

extension UIWindow {
    open override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionBegan(motion, with: event)
        NotificationCenter.default.post(name: .deviceDoShakeNotification, object: event)
    }
    
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        NotificationCenter.default.post(name: .deviceDidShakeNotification, object: event)
    }
}
