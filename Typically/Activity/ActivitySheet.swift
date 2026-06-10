//
//  ActivitySheet.swift
//  Typically
//
//  Created by Mohamed Anas Abbouchi on 10/06/2026.
//

import SwiftUI

struct ActivitySheet: View {

    let recents: [Activity]

    let onSubmit: (String) -> Void

    @State private var text = ""

    var body: some View {

        NavigationStack {

            VStack(spacing: 24) {

                TextField(
                    "What are you about to do?",
                    text: $text
                )
                .textFieldStyle(.roundedBorder)

                if !recents.isEmpty {

                    VStack(alignment: .leading) {

                        Text("Recent")
                            .font(.headline)

                        ScrollView(.horizontal) {

                            HStack {

                                ForEach(recents) { activity in

                                    Button(activity.name) {
                                        onSubmit(activity.name)
                                    }
                                    .buttonStyle(.borderedProminent)
                                }
                            }
                        }
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Start Activity")
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Start") {

                        guard !text.isEmpty else {
                            return
                        }

                        onSubmit(text)
                    }
                }
            }
        }
    }
}
