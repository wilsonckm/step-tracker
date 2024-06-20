//
//  DashboardView.swift
//  Step Tracker
//
//  Created by Wilson Chan on 4/29/24.
//

import SwiftUI
import Charts

//Picker cases
enum HealthMetricContent: CaseIterable, Identifiable {
    case steps, weight

    var id: Self { self }
    
    var title: String {
        switch self {
        case .steps:
            return "Steps"
        case .weight:
            return "Weight"
        }
    }
}

struct DashboardView: View {
    
    @Environment(HealthKitManager.self) private var hkManager
    @AppStorage("hasSeenPermissionPriming") private var hasSeenPermissionPriming = false
    @State private var isShowingPermissionPrimingSheet = false
    @State private var selectedStat: HealthMetricContent = .steps
    var isSteps: Bool { selectedStat == .steps }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20) {
                Picker("Selected Stat", selection: $selectedStat) {
                    ForEach(HealthMetricContent.allCases) {
                        Text($0.title)
                    }
                }
                .pickerStyle(.segmented)
                    StepBarChart(selectedStat: selectedStat, chartData: hkManager.stepData)
                    StepPieChart(chartData: ChartMath.averageWeekdayCount(for: hkManager.stepData))
                }
                .padding()
            }
            .padding()
            .task {
                await hkManager.fetchStepCount()
                isShowingPermissionPrimingSheet = !hasSeenPermissionPriming
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: HealthMetricContent.self) { metric in
                HealthDataListView(metric: metric)
            }
            .sheet(isPresented: $isShowingPermissionPrimingSheet) {
                //fetch health data
            } content: {
                HealthKitPermissionPrimingView(hasSeen: $hasSeenPermissionPriming)
            }
            
        }
        .tint(isSteps ? .pink : .indigo)
    }
}
#Preview {
    DashboardView()
        .environment(HealthKitManager())
}
