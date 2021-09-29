//
//  MeetingView.swift
//  Scrummaseter
//
//  Created by 김상진 on 2021/09/25.
//

import SwiftUI
import CoreData

struct MeetingView: View {
    var body: some View {
        VStack {
            ProgressView(value: 5, total: 15)
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("300", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("600", systemImage: "hourglass.tophalf.fill")
                }
            }
            .accessibilityElement(children: .ignore)    // 하위 항목들은 무시 ()
            .accessibilityLabel(Text("Time remaining")) // VoiceOver로 어떤 View인지 읽어줌
            .accessibilityValue(Text("10 minutes")) // View의 value가 어떻게 되는지 읽어줌
            
            Circle()
                .strokeBorder(lineWidth: 24, antialiased: true)
            HStack {
                Text("Speaker 1 of 3")
                Spacer()
                Button(action: {}) {
                    Image(systemName: "forward.fill")
                }
                .accessibilityLabel(Text("Next speaker"))
            }
        }
        .padding()
    }

}

struct MettingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
