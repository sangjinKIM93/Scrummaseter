//
//  TimerView.swift
//  Scrummaseter
//
//  Created by 김상진 on 2021/09/25.
//

import SwiftUI
import AVFoundation

struct TimerView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    
    private var startMinutes: Int {
        return 60 - scrum.lengthInMinutes
    }
    private var progress: Double {
        guard scrumTimer.secondsRemaining > 0  else { return 1 }
        return Double(scrumTimer.secondsElapsed + startMinutes * 60) / (60 * 60)
    }
    private var clockAngle: Angle {
        return Angle.degrees(progress * 360)
    }
    var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        // TODO: 크기는 기기 대응을 위해서 비뷸로 변경 (스크린 크기 대비)
        ZStack {
            Circle()
                .stroke(scrum.color, lineWidth: 130)
                .frame(width: 130, height: 130, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Ticks(inset: 40, minTickHeight: 5, hourTickHeight: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(.black)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(Color.white, lineWidth: 130)
                .frame(width: 130, height: 130, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .rotationEffect(Angle(degrees: -90))
            
            TickTextView(
                ticks: [0, 55, 50, 45, 40, 35, 30, 25, 20, 15, 10, 5].map{"\($0)"},
                inset: 20
            )
            .foregroundColor(.black)
            .font(Font.system(size: 20))
            
            Circle()
                .shadow(color: Color.gray, radius: 3)
                .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            ClockHand(inset: 150, angle: clockAngle)
                .stroke(lineWidth: 1)
                .foregroundColor(.gray)
            
        }
        .padding()
        .foregroundColor(scrum.color.accessibleFontColor)
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            scrumTimer.startScrum()
        }
        .onDisappear {
            scrumTimer.stopScrum()
            let newHistory = History(attendees: scrum.attendees, lengthInMinutes: scrumTimer.secondsElapsed / 60)
            scrum.history.insert(newHistory, at: 0)
        }
    }

}


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(scrum: .constant(DailyScrum.data[0]))
    }
}
