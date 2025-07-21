//
//  Constants.swift
//  Memorize
//
//  Created by Felipe Campelo on 27/07/25.
//

import CoreFoundation
import SwiftUICore

public struct Constants {
    public enum EmojiMemoryGameView {
        public static let cardAspectRatio: CGFloat = 2/3
        public static let cardPadding: CGFloat = 4.0
        public static let shuffleButtonLabel: String = "Shuffle"
    }
    
    public enum EmojiMemoryGame {
        public static let emojis = ["🦄", "🐇", "🐢", "🦎", "🦖", "🦕", "🦓", "🦔"]
        public static let emojiPairCount: Int = 12
        public static let color: Color = .orange
    }
    
    public enum MemoryGame {
        public static let suffleLogMessage: String = "[SHUFFLE INTENT]" + String(repeating: "*", count: 10)
        public static let chooseLogMessage: String = "[CHOOSE]" + String(repeating: "*", count: 10)
    }
    
    public enum CardView {
        public static let inset: CGFloat = 5
        public static let aspectRatio: CGFloat = 1
    }
    
    public enum FontSize {
        public static let largest: CGFloat = 200
        public static let smalest: CGFloat = 10
        public static let scaleFactor = smalest / largest
    }
    
    public enum Pie {
        public static let inset: CGFloat = 5
        public static let opacity: CGFloat = 0.5
        public static let endAngle: Angle = .degrees(270)
    }
    
    public enum Cardify {
        static let cornerRadius: CGFloat = 23.0
        static let lineWidth: CGFloat = 2.0
    }
    
    public enum Opacity {
        static let show: Double = 1
        static let hide: Double = 0
    }

}
