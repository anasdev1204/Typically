//
//  NavigationCarouselView.swift
//  Typically
//
//  Created by Mohamed Anas Abbouchi on 09/06/2026.
//

import SwiftUI
import AudioToolbox

struct NavigationCarouselView: View {
    let items: [ScreenItem]
    @Binding var selectedIndex: Int
    @State private var scrollPosition: Int?
    
    private let selectionFeedback = UISelectionFeedbackGenerator()
    
    var body: some View {
        GeometryReader { rootGeo in
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: NavigationCarouselConstants.itemsSpacing) {
                    
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        
                        GeometryReader { itemGeo in
                            
                            let frame = itemGeo.frame(in: .global)
                            
                            let screenCenter = rootGeo.frame(in: .global).midY
                            let itemCenter = frame.midY
                            
                            let distance = abs(screenCenter - itemCenter)
                            
                            let normalized = min(distance / NavigationCarouselConstants.distanceToNormalize , 1)
                            
                            let scale = 1 - (normalized * NavigationCarouselConstants.scaleFactor)
                            let opacity = 1 - (normalized * (NavigationCarouselConstants.opacityFactor))
                            
                            Button {
                                withAnimation(.spring(
                                    response: NavigationCarouselConstants.buttonSpringResponse,
                                    dampingFraction: NavigationCarouselConstants.buttonDampingFactor
                                )) {
                                    selectedIndex = index
                                }
                            } label: {
                                Image(systemName: item.icon)
                                    .font(.system(size: NavigationCarouselConstants.iconSize))
                                    .foregroundStyle(.black)
                                    .frame(width: NavigationCarouselConstants.frameSize, height: NavigationCarouselConstants.frameSize)
                                    .background {
                                        ZStack {
                                            if selectedIndex == index {
                                                RoundedRectangle(
                                                    cornerRadius: NavigationCarouselConstants.cornerRadius
                                                )
                                                .fill(.ultraThinMaterial)
                                            }
                                        }
                                    }
                            }
                            .disabled(true)
                            .scaleEffect(scale)
                            .opacity(opacity)
                            .animation(.smooth, value: distance)
                            .onChange(of: distance) { _, newDistance in
                                
                                let threshold = NavigationCarouselConstants.distanceThreshold
                                
                                if newDistance < threshold &&
                                    selectedIndex != index {
                                    selectedIndex = index
                                }
                            }
                        }
                        .frame(height: NavigationCarouselConstants.innerGeometryFrameHeight)
                        .id(index)
                        .scrollTargetLayout()
                    }
                }
                .padding(.vertical, rootGeo.size.height / 2 - NavigationCarouselConstants.itemOffset)
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $scrollPosition)
                .onChange(of: scrollPosition) { _, newValue in
                    if let newValue {
                        selectedIndex = newValue
                    }
                }
            }
        }
        .frame(width: NavigationCarouselConstants.stackFramewidth)
        .onChange(of: selectedIndex) { _, _ in
            selectionFeedback.selectionChanged()
            AudioServicesPlaySystemSound(1104)
        }
    }
}

#Preview {
    PreviewContainer()
}

private struct PreviewContainer: View {
    @State private var selectedIndex = 0

    var body: some View {
        NavigationCarouselView(
            items: ContentViewConstants.screens,
            selectedIndex: $selectedIndex
        )
    }
}
