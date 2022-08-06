//
//  BudgetUserDefaults.swift
//  Mankepri
//
//  Created by Maulana Frasha on 05/08/22.
//

import Foundation

struct BudgetUserDefaults {
    static let key = "Budget"
    static let userDefaults = UserDefaults.standard
    
    static func save(_ value: Int) {
        userDefaults.set(value, forKey: key)
    }
    static func get() -> Int {
        return userDefaults.integer(forKey: key)
    }
    
    static func check() -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    static func delete() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

struct SpendingBudgetUserDefaults {
    static let key = "SpendingBudget"
    static let userDefaults = UserDefaults.standard
    
    static func save(_ value: [TransactionDataModel]) {
        userDefaults.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    
    static func get() -> [TransactionDataModel] {
        var userData: [TransactionDataModel]!
        if let data = userDefaults.value(forKey: key) as? Data {
            userData = try? PropertyListDecoder().decode([TransactionDataModel].self, from: data)
            return userData!
        } else {
            return userData
        }
    }
    
    static func check() -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    static func delete() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
