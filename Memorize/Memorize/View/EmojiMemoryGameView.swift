//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 23/05/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    // MARK: - Attributes
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            cards
            shuffleButtonView
        }
        .padding()
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private var cards: some View {
        let isDebugEnabled = false
        let cardAspectRatio = Constants.EmojiMemoryGameView.cardAspectRatio
        let cardPadding = Constants.EmojiMemoryGameView.cardPadding
        
        AspectVGrid(viewModel.cards,
                    aspectRatio: cardAspectRatio) { card in
            CardView(card, enableDebugText: isDebugEnabled)
                .padding(cardPadding)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(Constants.EmojiMemoryGame.color)
    }
    
    @ViewBuilder
    private var shuffleButtonView: some View {
        let suffleButtonLabel = Constants.EmojiMemoryGameView.shuffleButtonLabel
        
        Button(suffleButtonLabel) {
            viewModel.shuffle()
        }
        .padding()
    }
}

// MARK: - Preview

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
