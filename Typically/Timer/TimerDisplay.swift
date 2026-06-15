//
//  TimerDisplay.swift
//  Typically
//
//  Created by Mohamed Anas Abbouchi on 10/06/2026.
//

import SwiftUI

struct TimerDisplay: View {
    let elapsedTime: TimeInterval

    var body: some View {
        Text(formattedTime)
            .font(.system(size: 42, weight: .medium, design: .rounded))
            .monospacedDigit()
    }

    private var formattedTime: String {
        let elapsed = Int(elapsedTime)

        let hours = elapsed / 3600
        let minutes = (elapsed % 3600) / 60

        return String(
            format: "%02d:%02d",
            hours,
            minutes
        )
    }
}
