//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 23/05/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    // MARK: - Properties
    
    typealias Card = MemoryGame<String>.Card
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            cards
            HStack {
                scoreView
                Spacer()
                shuffleButtonView
            }
            .font(.largeTitle)
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
                .overlay(FlyingNumberView(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: Constants.EmojiMemoryGameView.chooseCardAnimationDuration)) {
                        viewModel.choose(card)
                    }
                }
        }
        .foregroundColor(Constants.EmojiMemoryGame.color)
    }
    
    @ViewBuilder
    private var scoreView: some View {
        let scoreLabel = Constants.EmojiMemoryGameView.scoreLabel
        
        Text(String(format: scoreLabel,
                    "\(viewModel.score)"))
            .animation(nil)
    }
    
    @ViewBuilder
    private var shuffleButtonView: some View {
        let suffleButtonLabel = Constants.EmojiMemoryGameView.shuffleButtonLabel
        
        Button(suffleButtonLabel) {
            withAnimation {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    // MARK: - Functions
    
    private func scoreChange(causedBy card: Card) -> Int {
        return 0
    }
}

// MARK: - Preview

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
