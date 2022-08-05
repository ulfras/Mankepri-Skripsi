//
//  DateFormatter+Extenseion.swift
//  Mankepri
//
//  Created by Maulana Frasha on 05/08/22.
//

import Foundation

extension DateFormatter {
    func convertDateToString(from: Date, withFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        return dateFormatter.string(from: from)
    }
}
