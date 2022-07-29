//
//  UsernameUserDefaults.swift
//  Mankepri
//
//  Created by Maulana Frasha on 29/07/22.
//

import Foundation

struct UsernameUserDefaults {
    static let key = "Username"
    static let userDefaults = UserDefaults.standard
    static func save(_ value: String) {
        userDefaults.set(value, forKey: key)
    }
    static func get() -> String {
        return userDefaults.string(forKey: key)!
    }
    
    static func check() -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
