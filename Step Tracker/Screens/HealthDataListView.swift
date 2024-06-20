//
//  DataListView.swift
//  Step Tracker
//
//  Created by Wilson Chan on 5/5/24.
//

import SwiftUI

struct HealthDataListView: View {
    
    @State private var isShowingAddData = false
    @State private var valueToAdd: String = ""
    @State private var addDataDate: Date = .now
    
    var metric: HealthMetricContent
    
    var body: some View {
        List(0..<28) { i in
            HStack {
                Text(Date(), format: .dateTime.month().day().year())
                Spacer()
                Text(10000, format: .number.precision(.fractionLength(metric == .steps ? 0: 1)))
            }
        }
        .navigationTitle(metric.title)
        .sheet(isPresented: $isShowingAddData) {
            //Recommend adding to separate file as a struct -- permissable since its only used here and is a simple view. Easier since we don't have to pass any variables.
            addDataView
        }
        .toolbar {
            Button("Add Data", systemImage: "plus") {
                isShowingAddData = true
            }
        }
    }

    //Add Data Sheet
    var addDataView: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection:  $addDataDate, displayedComponents: .date)
                HStack {
                    Text(metric.title)
                    Spacer()
                    TextField("Value", text: $valueToAdd)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 140)
                        .keyboardType(metric == .steps ? .numberPad : .decimalPad)
                }
            }
            .navigationTitle(metric.title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Data") {
                        //To do code
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Dismiss") {
                        isShowingAddData = false
                    }
                }
            }
        }
    }
}
#Preview {
    NavigationStack {
        HealthDataListView(metric: .steps)
    }
}
