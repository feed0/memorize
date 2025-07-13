//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 23/05/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        
        VStack {
            
            cards
                .background(.blue.opacity(0.2))
                .animation(.bouncy, value: viewModel.cards)
            ShuffleButtonView
                .background()
        }
        .padding()
        .background(Color.green.opacity(0.2))
    }
    
    // MARK: - View builder
    
    @ViewBuilder
    var cards: some View {
        
        let aspectRatio: CGFloat = 2/3
        let isDebugEnabled = false
        let cardPadding = 4.0
        
        AspectVGrid(
            viewModel.cards,
            aspectRatio: aspectRatio
        ) { card in
            
            CardView(card, enableDebugText: isDebugEnabled)
                .padding(cardPadding)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(.orange)
    }
    
    @ViewBuilder
    private var ShuffleButtonView: some View {
        
        Button("Shuffle") {
            viewModel.shuffle()
        }
        .padding()
    }
}

// MARK: - CardView

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    let cornerRadius = 23.0
    let lineWidth = 2.0
    let fontSize = 80.0
    let isDebugTextEnabled: Bool
    
    init(_ card: MemoryGame<String>.Card, enableDebugText: Bool) {
        self.card = card
        self.isDebugTextEnabled = enableDebugText
    }
    
    var body: some View {
        
        VStack {
            
            /// Face and Back
            ZStack {
                
                let base = RoundedRectangle(cornerRadius: cornerRadius)
                
                /// Face
                Group {
                    
                    base.fill(.white)
                    base.strokeBorder(lineWidth: lineWidth)
                    Text(card.content)
                        .font(.system(size: fontSize))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1, contentMode: .fit)
                }
                .opacity(card.isFaceUp ? 1 : 0)
                
                /// Back
                base.fill()
                    .opacity(card.isFaceUp ? 0 : 1)
            }
            /// Matched
            .opacity(card.isMatched ? 0 : 1)
            .background()
            
            /// Card debug identifier
            if isDebugTextEnabled {
                Text(card.id)
                    .background()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
