//
//  ContentView.swift
//  Step Tracker
//
//  Created by Wilson Chan on 4/29/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20) {
                    VStack {
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
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .frame(height: 200)
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
            .navigationTitle("Dashboard")
        }
    }
}
#Preview {
    ContentView()
}
