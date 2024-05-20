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
    
    @Environment(HealthKitManager.self) private var hkManger
    
    @AppStorage("hasSeenPermissionPriming") private var hasSeenPermissionPriming = false
    @State private var isShowingPermissionPrimingSheet = false
    @State private var selectedStat: HealthMetricContent = .steps
    var isSteps: Bool { selectedStat == .steps }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Picker("Selected Stat", selection: $selectedStat) {
                    ForEach(HealthMetricContent.allCases) {
                        Text($0.title)
                    }
                }
                .pickerStyle(.segmented)
                
                VStack (spacing: 20) {
                    VStack {
                        NavigationLink(value: selectedStat) {
                            HStack {
                                VStack(alignment:.leading) {
                                    Label("Steps", systemImage: "figure.walk")
                                        .foregroundStyle(.pink)
                                        .font(.title3.bold())
                                    HStack {
                                        Text("Avg: 10k Steps")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 12)
                        
                        Chart {
                            ForEach(hkManger.stepData) { steps in
                                BarMark(x: .value("Date", steps.date, unit: .day),
                                        y: .value("Steps", steps.value)
                                )
                            }
                        }
                        .frame(height: 150)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(Color(.secondarySystemBackground)))
                    
                    VStack(alignment: .leading) {
                        VStack(alignment:.leading) {
                            Label("Averages", systemImage: "calendar")
                                .foregroundColor(.pink)
                                .font(.title3.bold())
                            HStack {
                                Text("Last 28 Days")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .frame(height: 200)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(Color(.secondarySystemBackground)))
                }
                .padding()
            }
            .padding()
            .task {
                await hkManger.fetchStepCount()
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
