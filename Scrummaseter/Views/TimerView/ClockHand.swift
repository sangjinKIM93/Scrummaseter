//
//  ClockHand.swift
//  Scrummaseter
//
//  Created by 김상진 on 2021/10/28.
//

import SwiftUI

struct ClockHand: Shape {
    let inset: CGFloat
    //1
    let angle: Angle
    
    //2
    func path(in rect: CGRect) -> Path {
        let rect = rect.insetBy(dx: inset, dy: inset)
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addRoundedRect(in: CGRect(x: rect.midX - 4, y: rect.midY - 4, width: 8, height: 8), cornerSize: CGSize(width: 8, height: 8))
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: position(for: CGFloat(angle.radians), in: rect))
        return path
    }
    
    //3
    private func position(for angle: CGFloat, in rect: CGRect) -> CGPoint {
        let angle = angle - (.pi/2)
        let radius = min(rect.width, rect.height)/2
        let xPosition = rect.midX + (radius * cos(angle))
        let yPosition = rect.midY + (radius * sin(angle))
        return CGPoint(x: xPosition, y: yPosition)
    }
}
