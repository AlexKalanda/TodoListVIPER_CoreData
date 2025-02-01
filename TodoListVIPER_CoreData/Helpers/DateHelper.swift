//
//  DateHelper.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 30/1/2025.
//

import Foundation

final class DateHelper {
    static func toString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: date)
    }
}
