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
                        .padding(Constants.Pie.inset)
                        .rotationEffect(.degrees(card.isMatched
                                                 ? Constants.CardView.RotationEffect.matched
                                                 : Constants.CardView.RotationEffect.unmatched))
                        .animation(.spin(duration: Constants.CardView.spinAnimationDuration),
                                   value: card.isMatched)
                )
                .padding(Constants.CardView.inset)
                .cardify(isFaceUp: card.isFaceUp,
                         isDebugTextEnabled: isDebugTextEnabled,
                         id: card.id,
                         isMatched: card.isMatched)
        }
    }
}

// MARK: - Animation extension

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: duration).repeatForever(autoreverses: false)
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
                              content: cardContent,
                              isFaceUp: false),
                         enableDebugText: true)
                
                CardView(Card(id: cardId,
                              content: cardContent,
                              isFaceUp: true),
                         enableDebugText: true)
            }
            
            Divider()
            
            Text("Matched cards")
            
            HStack {
                let cardId = "Card ID 001"
                let cardContent = "🐦‍🔥"
                
                CardView(Card(id: cardId,
                              isMatched: true,
                              hasBeenSeen: true,
                              content: cardContent,
                              isFaceUp: true),
                         enableDebugText: true)
                
                CardView(Card(id: cardId,
                              isMatched: true,
                              hasBeenSeen: true,
                              content: cardContent,
                              isFaceUp: false),
                         enableDebugText: true)
            }
            
        }
        .padding()
        .foregroundColor(.red)
    }
}
