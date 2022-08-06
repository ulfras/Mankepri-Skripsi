//
//  BiometricSwitchUserDefaults.swift
//  Mankepri
//
//  Created by Maulana Frasha on 29/07/22.
//

import Foundation

struct BiometricSwitchCache {
    static let key = "biometricSwitch"
    static let userDefaults = UserDefaults.standard
    
    static func save(_ value: Bool) {
        userDefaults.set(value, forKey: key)
    }
    
    static func get() -> Bool {
        return userDefaults.bool(forKey: key)
    }
}
