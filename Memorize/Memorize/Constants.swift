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
        public static let chooseCardAnimationDuration: TimeInterval = 0.4
        public static let scoreLabel = "Score: %@"
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
        public static let spinAnimationDuration: TimeInterval = 0.4
        
        public struct RotationEffect {
            public static let matched = 360.0
            public static let unmatched = 0.0
        }
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
        public static let cornerRadius: CGFloat = 23.0
        public static let lineWidth: CGFloat = 2.0
        
        public struct Rotation3dEffectAngles {
            public static let matched = 0.0
            public static let unmatched = 180.0
            public static let yAxis: (CGFloat, CGFloat, CGFloat) = (0, 1, 0)
            
        }
        
        public struct IsFaceUpRotation {
            public static let threshold = 90.0
            public static let isUp = 0.0
            public static let isDown = 180.0
        }
    }
    
    public enum Opacity {
        public static let show: Double = 1
        public static let hide: Double = 0
    }
}
