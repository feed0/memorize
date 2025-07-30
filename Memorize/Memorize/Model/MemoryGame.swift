//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 02/06/25.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    // MARK: - Attributes
    
    private(set) var cards: [Card]
    private(set) var score = 0
    
    // MARK: - Init
    
    init(cardPairsCount: Int,
         cardContentFactory: (Int) -> CardContent) {
        
        cards = []
        
        for pairIndex in 0 ..< max(2, cardPairsCount) {
            let content = cardContentFactory(pairIndex)
            let pairIdSuffix = ["a", "b"]

            for id in pairIdSuffix {
                cards.append(Card(id: "\(pairIndex + 1)-\(id)",
                                  content: content,
                                  isFaceUp: false
                ))
            }
        }
    }
    
    // MARK: - Computed properties
    
    var indexOfTheOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    // MARK: - Intents
    
    mutating func shuffle() {
        cards.shuffle()
        
        print(Constants.MemoryGame.suffleLogMessage, cards)
    }
    
    mutating func choose(_ card: Card) { // FIXME: - change finding a Card by id to finding by memory address hex

        print(Constants.MemoryGame.chooseLogMessage, card)

        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                
                if let potentialMatchIndex = indexOfTheOnlyFaceUpCard {
                    
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        
                        score += 2
                    } else {
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                } else {
                    indexOfTheOnlyFaceUpCard = chosenIndex
                }
                
                cards[chosenIndex].isFaceUp = true
            }
        }
        
    }
    
    // MARK: - Card
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var id: String
        var isMatched: Bool = false
        
        var hasBeenSeen: Bool = false
        let content: CardContent
        
        var isFaceUp: Bool {
            didSet {
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        
        var debugDescription: String {
            """
            Card [\(id)]: \(content) \t| \(isFaceUp ? "up" : "down") \t| \(isMatched ? "matched" : "unmatched")
            """
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
