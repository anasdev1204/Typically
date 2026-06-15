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
    @State private var showingFullText = false
    @State private var hideTooltipTask: Task<Void, Never>?
    
    private var elapsedTime: TimeInterval {
        guard let startDate else {
            return 0
        }

        return Date().timeIntervalSince(startDate)
    }

    private var timerProgress: CGFloat {
        let cycle: TimeInterval = 60 * 60 // 1 hour

        return CGFloat(
            elapsedTime.truncatingRemainder(dividingBy: cycle) / cycle
        )
    }

    var body: some View {

        VStack(spacing: 32) {

            Spacer()

            if let currentActivity {
                Text(currentActivity.name)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            ZStack {

                Circle()
                    .trim(from: 0.15, to: 0.85)
                    .stroke(
                        Color.gray.opacity(0.25),
                        lineWidth: 12
                    )
                    .rotationEffect(.degrees(90))
                    .frame(width: 240, height: 240)

                if currentActivity != nil {

                    Circle()
                        .trim(
                            from: 0.15,
                            to: 0.15 + (0.70 * timerProgress)
                        )
                        .stroke(
                            .blue,
                            style: StrokeStyle(
                                lineWidth: 12,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(.degrees(90))
                        .frame(width: 240, height: 240)
                        .animation(.linear(duration: 1), value: timerProgress)
                    
                }

                VStack(spacing: 8) {

                    TimerDisplay(elapsedTime: elapsedTime)

                    
                    Text(currentActivity?.name ?? "Not tracking")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .onTapGesture {
                            withAnimation {
                                showingFullText.toggle()
                            }
                            
                            hideTooltipTask?.cancel()

                            hideTooltipTask = Task {
                                try? await Task.sleep(for: .seconds(1))

                                guard !Task.isCancelled else {
                                    return
                                }

                                await MainActor.run {
                                    withAnimation {
                                        showingFullText = false
                                    }
                                }
                            }
                        }
                        .overlay(alignment: .top) {
                            if showingFullText {
                                Text(currentActivity?.name ?? "Not tracking")
                                    .font(.callout)
                                    .padding(10)
                                    .background(.regularMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .fixedSize()
                                    .offset(y: -50)
                                    .transition(.scale.combined(with: .opacity))
                            }
                        }
                }
            }

            Button {

                if currentActivity == nil {
                    showingActivitySheet = true
                }

            } label: {

                Image(systemName: currentActivity == nil ? "plus" : "stop.fill")    
                    .font(.title2.weight(.medium))
                    .foregroundStyle(.white)
                    .frame(width: 60, height: 60)
                    .background(
                        Circle()
                            .fill(currentActivity == nil ? .blue : .red)
                    )
                    .overlay(
                        Circle()
                            .stroke(
                                Color.gray.opacity(0.3),
                                lineWidth: 2
                            )
                    )
            }
            .onLongPressGesture(minimumDuration: 1) {

                guard currentActivity != nil else {
                    return
                }

                currentActivity = nil
                startDate = nil

                showingActivitySheet = true
            }
//            .sheet(isPresented: $showingActivitySheet) {
//                ActivitySheet(
//                    recents: store.recents
//                ) { name, estimatedMinutes in
//
//                    let activity = Activity(
//                        name: name,
//                        estimatedMinutes: estimatedMinutes
//                    )
//
//                    store.add(activity)
//
//                    currentActivity = activity
//                    startDate = Date()
//                }
//                .presentationDetents([.medium])
//            }

            Spacer()
        }
    }
}


#Preview {
    TimerView()
}
