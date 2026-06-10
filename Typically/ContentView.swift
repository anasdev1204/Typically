//
//  ContentView.swift
//  Typically
//
//  Created by Mohamed Anas Abbouchi on 08/06/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack(spacing: 0) {

            NavigationCarouselView(
                items: ContentViewConstants.screens,
                selectedIndex: $selectedIndex
            )
            .padding(ContentViewConstants.navigationPadding)
            
            CurrentScreenView(index: selectedIndex)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
        }
    }
}

struct CurrentScreenView: View {
    let index: Int
    
    var body: some View {
        TimerView()
    }
}

#Preview {
    ContentView()
}
