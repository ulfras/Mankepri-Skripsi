//
//  CategoryDataUserDefaults.swift
//  Mankepri
//
//  Created by Maulana Frasha on 01/08/22.
//

import Foundation

struct CategoryDataDefaults {
    static let key = "CategoryData"
    static let userDefaults = UserDefaults.standard
    
    static func save(_ value: [String]) {
        userDefaults.set(value, forKey: key)
    }
    
    static func get() -> [String] {
        return userDefaults.stringArray(forKey: key)!
    }
    
    static func check() -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    static func delete() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
