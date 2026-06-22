//
//  ActivitySheet.swift
//  Typically
//
//  Created by Mohamed Anas Abbouchi on 10/06/2026.
//

import SwiftUI

struct ActivitySheet: View {

    let recents: [Activity]
    let onSubmit: (String, Int) -> Void

    @State private var text = ""
    @State private var hours = ""
    @State private var minutes = ""
    @State private var estimatedTime = 60

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                VStack(spacing: 16) {

                    VStack(alignment: .leading, spacing: 4) {

                        Text("Activity")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        TextField(
                            "Gym, cook dinner...",
                            text: $text
                        )
                        .font(.caption)
                        .textFieldStyle(.roundedBorder)
                    }
                    
             

                    HStack(spacing: 12) {

                        VStack(alignment: .leading, spacing: 4) {

                            Text("Hours")
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            TextField("0", text: $hours)
                                .font(.caption)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                        }

                        VStack(alignment: .leading, spacing: 4) {

                            Text("Minutes")
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            TextField("0", text: $minutes)
                                .font(.caption)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                        }
                    }

                    Button {

                        guard !text.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty else {
                            return
                        }

                        onSubmit(
                            text,
                            estimatedTime
                        )

                    } label: {

                        Label(
                            "Start Activity",
                            systemImage: "play.fill"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
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



                VStack(alignment: .leading, spacing: 12) {
                    Text("Recent")
                        .font(.headline)
                        
                    if !recents.isEmpty {
                        LazyVStack(spacing: 12) {

                            ForEach(recents) { activity in

                                ActivityCard(
                                    activity: activity
                                ) {
                                    onSubmit(
                                        activity.name,
                                        activity.estimatedTime
                                    )
                                }
                            }
                        }
                }
                }
            }
            .padding()
        }
        .navigationTitle("Start Activity")
        
    }
}

#Preview {
    ActivitySheet(
        recents: [
            Activity(
                name: "Study SwiftUI",
                estimatedTime: 60
            ),
            Activity(
                name: "Workout",
                estimatedTime: 90
            )
        ]
    ) { name, estimatedTime in
        print(name, estimatedTime)
    }
}
