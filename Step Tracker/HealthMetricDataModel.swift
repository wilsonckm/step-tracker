//
//  HealthMetricDataModel.swift
//  Step Tracker
//
//  Created by Wilson Chan on 5/19/24.
//

import Foundation

struct HealthMetric: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
