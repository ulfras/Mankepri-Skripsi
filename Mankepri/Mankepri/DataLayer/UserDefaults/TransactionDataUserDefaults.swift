//
//  TransactionDataUserDefaults.swift
//  Mankepri
//
//  Created by Maulana Frasha on 03/08/22.
//

import Foundation

struct TransactionDataUserDefaults {
    static let key = "TransactionData"
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
}
