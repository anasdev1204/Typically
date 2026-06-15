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
    let estimatedTime: Int?

    init(name: String) {
        self.id = UUID()
        self.name = name
        self.estimatedTime = nil
    }
}
