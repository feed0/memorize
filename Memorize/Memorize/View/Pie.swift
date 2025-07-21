//
//  Pie.swift
//  Memorize
//
//  Created by Felipe Campelo on 20/07/25.
//

import SwiftUI
import CoreGraphics

struct Pie: Shape {
    
    var startAngle: Angle = .zero
    let endAngle: Angle
    var isClockwise = true 
    
    func path(in rect: CGRect) -> Path {
        
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)
        
        var p = Path()
        
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX,
                             y: rect.midY)
        let startPoint = CGPoint(x: center.x + radius * cos(startAngle.radians),
                                 y: center.y + radius * sin(startAngle.radians))
        
        p.move(to: center)
        p.addLine(to: startPoint)
        p.addArc(center: center,
                 radius: radius,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: isClockwise)
        p.addLine(to: center)
        
        return p
    }
}

#Preview {
    Pie(endAngle: Angle(degrees: 240))
}
