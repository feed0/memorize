//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 11/07/25.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    
    let items: [Item]
    let gridItemSpacing = 0.0
    let aspectRatio: CGFloat
    
    let content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let gridItemSize = gridItemWidthThatFits(
                cardCount: items.count,
                cardSize: geometry.size,
                atAspectRatio: aspectRatio
            )
            
            LazyVGrid(
                columns: [GridItem(
                    .adaptive(minimum: gridItemSize),
                    spacing: gridItemSpacing)
                ],
                spacing: gridItemSpacing
            ) {
                
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
}

// MARK: - Grid that fits

func gridItemWidthThatFits(
    cardCount: Int,
    cardSize: CGSize,
    atAspectRatio aspectRatio: CGFloat
) -> CGFloat {
    
    let cardCount = CGFloat(cardCount)
    var columnCount = 1.0
    
    repeat {
        
        let width = cardSize.width / columnCount
        let height = width / aspectRatio
        
        let rowCount = (cardCount / columnCount)
            .rounded(.up)
        
        if rowCount * height < cardSize.height {
            return (cardSize.width / columnCount)
                .rounded(.down)
        }
        
        columnCount += 1
        
    } while columnCount < cardCount
    
    return min(cardSize.width / cardCount, cardSize.height * aspectRatio)
        .rounded(.down)
}

// MARK: - Preview

#Preview {
    struct IdentifiableString: Identifiable {
        let id = UUID()
        let value: String
    }

    let items = ["a", "b", "c", "d", "e", "f", "g", "h"].map { IdentifiableString(value: $0) }
    let aspectRatio: CGFloat = 2.0

    return AspectVGrid(items, aspectRatio: aspectRatio) { item in
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.white)
            Text(item.value)
                .font(.largeTitle)
                .foregroundColor(.black)
        }
    }
    .padding(10.0)
    .background(.red.opacity(0.2))
}
