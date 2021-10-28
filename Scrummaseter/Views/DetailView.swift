//
//  DetailView.swift
//  Scrummaseter
//
//  Created by 김상진 on 2021/09/29.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    @State private var data: DailyScrum.Data = DailyScrum.Data()
    @State private var isPresented = false
    
    var body: some View {
        List {
            Section(header: Text("Habit Info")) {
                NavigationLink(destination: TimerView(scrum: $scrum)) {
                    Label("Focusing Habit", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .accessibilityLabel(Text("Start meeting"))
                }
                HStack {
                    Label("Length(per Day)", systemImage: "clock")
                        .accessibilityLabel(Text("Meeting length"))
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                HStack {
                    Label("Color", systemImage: "paintpalette")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(scrum.color)
                }
                .accessibilityElement(children: .ignore)
            }
//            Section(header: Text("Attendees")) {
//                ForEach(scrum.attendees, id: \.self) { attendee in
//                    Label(attendee, systemImage: "person")
//                        .accessibilityLabel(Text("Person"))
//                        .accessibilityValue(Text(attendee))
//                }
//            }
            Section(header: Text("History")) {
                if scrum.history.isEmpty {
                    Label("No History yet", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(scrum.history) { history in
                    HStack {
                        Image(systemName: "calendar")
                        Text(history.date, style: .date)
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button("Edit") {
            isPresented = true
            data = scrum.data
            // 왜 scrum 그대로 넘겨주지 않고, data를 생성해서 넘겨주는거지?
            // 형 변환을 위한 것일수도
        })
        .navigationTitle(scrum.title)
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                EditView(scrumData: $data)
                    .navigationTitle(scrum.title)
                    .navigationBarItems(leading: Button("Cancel") {
                        isPresented = false
                    }, trailing: Button("Done") {
                        isPresented = false
                        scrum.update(from: data)
                    })
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: .constant(DailyScrum.data[0]))
        }
    }
}
