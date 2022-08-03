//
//  TransactionDataModel.swift
//  Mankepri
//
//  Created by Maulana Frasha on 03/08/22.
//

import Foundation

struct TransactionDataModel: Codable {
    let money: Int
    let category: String
    let description: String
    let date: Date
    let type: String
}
