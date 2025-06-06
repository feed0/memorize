//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 03/06/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static let emojis = ["🦄", "🐇", "🐢", "🦎", "🦖", "🦕", "🦓", "🦔"]
    
    private static let noEmojiPairs = 16
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(with: noEmojiPairs) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "❌"
            }
            
        }
    }
    
    @Published
    private var model = createMemoryGame()

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
