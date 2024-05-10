//
//  HealthKitManager.swift
//  Step Tracker
//
//  Created by Wilson Chan on 5/9/24.
//

import Foundation
import HealthKit
import Observation

@Observable class HealthKitManager {
    let store = HKHealthStore()
    
    let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]
}
