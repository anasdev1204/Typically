//
//  ActivityCard.swift
//  Typically
//
//  Created by Mohamed Anas Abbouchi on 23/06/2026.
//

import SwiftUI

struct ActivityCard: View {

    let activity: Activity
    let action: () -> Void

    var body: some View {

        Button(action: action) {
            HStack {

                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {

                    Text(activity.name)
                        .font(.headline)

                    Text(durationText(activity.estimatedTime))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text(relativeDate(for: activity.lastDone))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.tertiarySystemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(
                        Color(.separator).opacity(0.5),
                        lineWidth: 2
                    )
            )
            .shadow(
                color: .black.opacity(0.06),
                radius: 3,
                x: 0,
                y: 2
            )
        }
        .buttonStyle(.plain)
    }

    private func relativeDate(for date: Date?) -> String {

        guard let date else {
            return "Never"
        }

        let days = Calendar.current.dateComponents(
            [.day],
            from: date,
            to: .now
        ).day ?? 0

        switch days {
        case 0:
            return "Less than a day ago"
        case 1:
            return "1 day ago"
        case 2:
            return "2 days ago"
        case 3...6:
            return "More than 3 days ago"
        default:
            return "More than a week ago"
        }
    }

    private func durationText(_ minutes: Int) -> String {

        let hours = minutes / 60
        let mins = minutes % 60

        if hours > 0 && mins > 0 {
            return "\(hours)h \(mins)m"
        }

        if hours > 0 {
            return "\(hours)h"
        }

        return "\(mins)m"
    }
}

#Preview {
    ActivityCard(activity:  Activity(
        name: "Study SwiftUI",
        estimatedTime: 60
    )) {
            print("hey")
    }
}
