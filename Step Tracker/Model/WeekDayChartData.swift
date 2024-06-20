//
//  WeekDayChartData.swift
//  Step Tracker
//
//  Created by Wilson Chan on 5/27/24.
//

import Foundation

struct WeekdayChartData: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
