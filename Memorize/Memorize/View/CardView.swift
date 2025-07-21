//
//  CardView.swift
//  Memorize
//
//  Created by Felipe Campelo on 20/07/25.
//

import SwiftUI

struct CardView: View {
    
    // MARK: - Attributes
    
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    let isDebugTextEnabled: Bool
    
    // MARK: - Init
    
    init(_ card: Card, enableDebugText: Bool) {
        self.card = card
        self.isDebugTextEnabled = enableDebugText
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Pie(endAngle: Constants.Pie.endAngle)
                .opacity(Constants.Pie.opacity)
                .overlay(
                    Text(card.content)
                        .font(.system(size: Constants.FontSize.largest))
                        .minimumScaleFactor(Constants.FontSize.scaleFactor)
                        .aspectRatio(Constants.CardView.aspectRatio, contentMode: .fit)
                        .padding(Constants.Pie.inset  )
                )
                .padding(Constants.CardView.inset)
                .cardify(isFaceUp: card.isFaceUp,
                         isDebugTextEnabled: isDebugTextEnabled,
                         id: card.id,
                         isMatched: card.isMatched)
        }
    }
}

// MARK: - Preview

#Preview {
    PreviewView()
}

private struct PreviewView: View {
    typealias Card = MemoryGame<String>.Card
    
    var body: some View {
        VStack {
            Text("Some cards")
            
            HStack {
                let cardId = "Card ID 000"
                let cardContent = "😌"
                CardView(Card(id: cardId,
                              content: cardContent),
                         enableDebugText: true)
                
                CardView(Card(id: cardId,
                              isFaceUp: true,
                              content: cardContent),
                         enableDebugText: true)
            }
            
            Divider()
            
            Text("Matched cards")
            
            HStack {
                let cardId = "Card ID 001"
                let cardContent = "🐦‍🔥"
                
                CardView(Card(id: cardId,
                              isFaceUp: true,
                              isMatched: true,
                              content: "🐦‍🔥"),
                         enableDebugText: true)
                
                CardView(Card(id: cardId,
                              isFaceUp: true,
                              isMatched: true,
                              content: "🐦‍🔥"),
                         enableDebugText: true)
            }
            
        }
        .padding()
        .foregroundColor(.red)
    }
}
