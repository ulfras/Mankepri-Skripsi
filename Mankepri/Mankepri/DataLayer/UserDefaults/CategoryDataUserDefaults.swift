//
//  CategoryDataUserDefaults.swift
//  Mankepri
//
//  Created by Maulana Frasha on 01/08/22.
//

import Foundation

struct CategoryDataIncomeDefaults {
    static let key = "CategoryDataIncome"
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

struct CategoryDataSpendingDefaults {
    static let key = "CategoryDataSpending"
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
