//
//  ActivityStruct.swift
//  Typically
//
//  Created by Mohamed Anas Abbouchi on 10/06/2026.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let estimatedTime: Int
    var lastDone: Date?

    init(name: String, estimatedTime: Int) {
        self.id = UUID()
        self.name = name
        self.estimatedTime = estimatedTime
        self.lastDone = .now
    }

    mutating func updateLastDone() {
        lastDone = .now
    }
}
