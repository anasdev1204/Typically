//
//  TimerView.swift
//  Typically
//
//  Created by Mohamed Anas Abbouchi on 10/06/2026.
//

import SwiftUI

struct TimerView: View {

    @State private var store = ActivityStore()

    @State private var currentActivity: Activity?
    @State private var startDate: Date?

    @State private var showingActivitySheet = false

    var body: some View {

        VStack(spacing: 40) {

            Spacer()

            Text("Ready to get stuff done?")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)

            if let currentActivity {

                Text(currentActivity.name)
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }

            TimerDisplay(startDate: startDate)

            Button {

                if currentActivity == nil {
                    showingActivitySheet = true
                }

            } label: {

                Circle()
                    .fill(currentActivity == nil ? .blue : .red)
                    .frame(width: 180, height: 180)
                    .overlay {

                        Text(currentActivity == nil ? "Ready" : "Hold To Stop")
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
            }
            .onLongPressGesture(minimumDuration: 1.0) {

                guard currentActivity != nil else { return }

                currentActivity = nil
                startDate = nil

                showingActivitySheet = true
            }

            Spacer()
        }
        .sheet(isPresented: $showingActivitySheet) {

            ActivitySheet(
                recents: store.recents
            ) { activityName in

                let activity = Activity(name: activityName)

                store.add(activity)

                currentActivity = activity
                startDate = Date()
            }
            .presentationDetents([.medium, .large])
        }
    }
}


#Preview {
    TimerView()
}
