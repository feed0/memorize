//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 03/06/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    // MARK: - Attributes
    
    private static let emojis = Constants.EmojiMemoryGame.emojis
    private static let emojiPairCount = Constants.EmojiMemoryGame.emojiPairCount
        
    typealias Card = MemoryGame<String>.Card
    
    // MARK: - Create memory game
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(cardPairsCount: emojiPairCount) {
            pairIndex in /// model.init(..., cardContentFactory: (Int) -> CardContent)
            
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }
            else {
                return "❌"
            }
        }
    }
    
    // MARK: - Model
    
    @Published
    private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    var color: Color {
          .orange
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
