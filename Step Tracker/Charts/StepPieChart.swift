//
//  StepPieChart.swift
//  Step Tracker
//
//  Created by Wilson Chan on 6/1/24.
//

import SwiftUI
import Charts

struct StepPieChart: View {
    
    @State private var selectedChartValue: Double? = 0
    
    var selectedWeekday: WeekdayChartData? {
        guard let selectedChartValue else { return nil }
        var total = 0.0
        return chartData.first {
            total += $0.value
            return selectedChartValue <= total
        }
    }
    
    var chartData: [WeekdayChartData]
    
    
    
    var body: some View {
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
            Chart {
                ForEach(chartData) { weekday in
                    SectorMark(angle: .value("Average Steps", weekday.value),
                               innerRadius: .ratio(0.618),
                               outerRadius: selectedWeekday?.date.weekdayInt == weekday.date.weekdayInt ? 140: 110,
                               angularInset: 1)
                    .foregroundStyle(.pink.gradient)
                    .cornerRadius(6)
                    .opacity(selectedWeekday?.date.weekdayInt == weekday.date.weekdayInt ? 1.0 : 0.3)
                }
            }
            .chartAngleSelection(value: $selectedChartValue.animation(.easeInOut))
            .frame(height: 240)
            .chartBackground { proxy in
                GeometryReader { geo in
                    if let plotFrame = proxy.plotFrame {
                        let frame = geo[plotFrame]
                        if let selectedWeekday {
                            VStack {
                                Text(selectedWeekday.date.weekdayTitle)
                                    .font(.title3.bold())
                                    .animation(.easeIn.speed(2.0))
                                Text(selectedWeekday.value, format: .number.precision(.fractionLength(0)))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.secondary)
                                    .contentTransition(.numericText())
                            }
                            .position(x: frame.midX, y: frame.midY)
                        }
                    }
                    
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(Color(.secondarySystemBackground)))
        .onChange(of: selectedChartValue) { oldValue, newValue in
            print(selectedWeekday?.date.weekdayTitle)
        }
    }
}

#Preview {
    StepPieChart(chartData: ChartMath.averageWeekdayCount(for: HealthMetric.mockData))
}
