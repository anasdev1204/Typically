//
//  TimerDisplay.swift
//  Typically
//
//  Created by Mohamed Anas Abbouchi on 10/06/2026.
//

import SwiftUI

struct TimerDisplay: View {

    let startDate: Date?

    var body: some View {

        TimelineView(.periodic(from: .now, by: 1)) { _ in

            Text(elapsedString)
                .font(.system(size: 52, weight: .bold, design: .rounded))
                .monospacedDigit()
        }
    }

    private var elapsedString: String {

        guard let startDate else {
            return "00:00:00"
        }

        let elapsed = Int(Date().timeIntervalSince(startDate))

        let hours = elapsed / 3600
        let minutes = (elapsed % 3600) / 60
        let seconds = elapsed % 60

        return String(
            format: "%02d:%02d:%02d",
            hours,
            minutes,
            seconds
        )
    }
}
