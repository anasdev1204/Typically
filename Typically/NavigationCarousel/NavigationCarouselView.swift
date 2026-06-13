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
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: NavigationCarouselConstants.itemsSpacing) {
                    
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        
                        GeometryReader { itemGeo in
                            
                            let frame = itemGeo.frame(in: .global)
                            
                            let screenCenter = rootGeo.frame(in: .global).midX
                            let itemCenter = frame.midX
                            
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
                                HStack(spacing: 6) {
                                      Image(systemName: item.icon)
                                          .font(.system(size: NavigationCarouselConstants.iconSize))
                        

                                    Text(item.title)
                                        .font(.caption)
                                        .foregroundStyle(.primary)
                                        .opacity(selectedIndex == index ? 1 : 0)
                                        .offset(y: selectedIndex == index ? 0 : 6)
                                  }
                                .frame(width: 100)
                            }
                            .disabled(true)
                            .scaleEffect(scale)
                            .opacity(opacity)
                            .animation(.smooth, value: distance)
                            .onChange(of: distance) { _, newDistance in
                                
                                let threshold = NavigationCarouselConstants.distanceThreshold - 10
                                
                                if newDistance < threshold &&
                                    selectedIndex != index {
                                    selectedIndex = index
                                }
                            }
                            .foregroundStyle(.blue)
                            .frame(
                                height: NavigationCarouselConstants.frameSize
                            )
                            .background {
                                if selectedIndex == index {
                                    RoundedRectangle(
                                        cornerRadius: NavigationCarouselConstants.cornerRadius
                                    )
                                    .fill(.ultraThinMaterial)
                                }
                            }
                        }
                        .frame(width: NavigationCarouselConstants.innerGeometryFrameWidth)
                        .id(index)
                        .scrollTargetLayout()
                    }
                }
                .padding(.horizontal, rootGeo.size.width / 2 - NavigationCarouselConstants.itemOffset)
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $scrollPosition)
                .onChange(of: scrollPosition) { _, newValue in
                    if let newValue {
                        selectedIndex = newValue
                    }
                }
            }
        }
        .frame(height: NavigationCarouselConstants.stackFrameHeight)
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
