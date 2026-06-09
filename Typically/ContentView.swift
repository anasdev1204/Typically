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
        HStack(spacing: 0) {

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
    
    private func getCurrentScreenText() -> String {
        return ContentViewConstants.screens[index].title
    }
    
    var body: some View {
        Text(getCurrentScreenText())
    }
}

#Preview {
    ContentView()
}
