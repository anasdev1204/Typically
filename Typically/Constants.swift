//
//  Constants.swift
//  Typically
//
//  Created by Mohamed Anas Abbouchi on 09/06/2026.
//

import Foundation
import SwiftUI

struct ScreenItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}


struct ContentViewConstants {
    static let screens = [
        ScreenItem(title: "Activity", icon: "timer"),
        ScreenItem(title: "Calendar", icon: "calendar"),
        ScreenItem(title: "Analytics", icon: "chart.line.text.clipboard")
    ]
    
    static let navigationPadding: CGFloat = 10
}

struct NavigationCarouselConstants {
    static let itemsSpacing: CGFloat = 6
    static let distanceToNormalize: CGFloat = 200
    
    static let scaleFactor: Double = 0.6
    static let opacityFactor: Double = 0.9

    static let buttonSpringResponse: Double = 0.35
    static let buttonDampingFactor: Double = 0.8

    static let iconSize: CGFloat = 15
    static let frameSize: CGFloat = 45
    static let cornerRadius: CGFloat = 120

    static let distanceThreshold: CGFloat = 45

    static let innerGeometryFrameHeight: CGFloat = 70

    static let itemOffset: CGFloat = 50

    static let stackFramewidth: CGFloat = 45
}





