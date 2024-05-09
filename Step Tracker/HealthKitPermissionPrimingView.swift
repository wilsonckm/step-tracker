//
//  HealthKitPermissionPrimingView.swift
//  Step Tracker
//
//  Created by Wilson Chan on 5/9/24.
//

import SwiftUI

struct HealthKitPermissionPrimingView: View {
    
    var description = """
    This app displays your step and weight data in interative charts
    
    You can also add new step or weight data to Apple Health from this app.
    
    Your data is private and secured.
    """
    var body: some View {
        VStack(spacing: 130) {
            VStack(alignment: .leading, spacing: 10) {
                Image(.appleHealth)
                    .resizable()
                    .frame(width: 90,height: 90)
                    .shadow(color: .gray.opacity(0.3), radius: 16)
                Text("Apple Health Integration")
                    .font(.title2).bold()
                Text(description)
                    .foregroundStyle(.secondary)
            }
                Button("Connect Apple Health") {
                    //To do: Ask for health permissions
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
            }
            .padding(30)
        }
    }

#Preview {
    HealthKitPermissionPrimingView()
}
