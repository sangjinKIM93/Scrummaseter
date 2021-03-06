//
//  TickTextView.swift
//  Scrummaseter
//
//  Created by 김상진 on 2021/10/26.
//
// https://www.thirdrocktechkno.com/blog/getting-started-with-swiftui/

import SwiftUI

struct TickTextView: View {
    //1
    var ticks: [String]
    var inset: CGFloat
    
    //2
    private struct IdentifiableTicks: Identifiable {
        var id: Int
        var tick: String
    }
    
    //3
    private var dataSource: [IdentifiableTicks] {
        self.ticks.enumerated().map { IdentifiableTicks(id: $0, tick: $1) }
    }
    
    var body: some View {
        //4
        GeometryReader { proxy in
            ZStack {
                ForEach(self.dataSource) {
                    Text("\($0.tick)")
                        .position(
                            //5
                            self.position(for: $0.id, in: proxy.frame(in: .local))
                        )
                }
            }
        }
    }
    
    //6
    private func position(for index: Int, in rect: CGRect) -> CGPoint {
        let rect = rect.insetBy(dx: inset, dy: inset)
        let angle = ((2 * .pi) / CGFloat(ticks.count) * CGFloat(index)) - .pi/2
        let radius = min(rect.width, rect.height)/2
        return CGPoint(x: rect.midX + radius * cos(angle),
                       y: rect.midY + radius * sin(angle))
    }
}

struct TickTextView_Previews: PreviewProvider {
    static var previews: some View {
        TickTextView(ticks: ["1","2","3","4","5","6","7","8","9","10","11","12"], inset: 1)
    }
}
