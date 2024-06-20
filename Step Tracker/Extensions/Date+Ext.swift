//
//  Date+Ext.swift
//  Step Tracker
//
//  Created by Wilson Chan on 5/28/24.
//

import Foundation

extension Date {
    var weekdayInt: Int {
        Calendar.current.component(.weekday, from: self)
    }
    
    var weekdayTitle: String {
        self.formatted(.dateTime.weekday(.wide))
    }
}
