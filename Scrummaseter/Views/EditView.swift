//
//  EditView.swift
//  Scrummaseter
//
//  Created by 김상진 on 2021/09/29.
//

import SwiftUI

struct EditView: View {
    @Binding var scrumData: DailyScrum.Data
    @State private var newAttendee = ""
    
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrumData.title)
                HStack {
                    Slider(value: $scrumData.lengthInMinutes, in: 5...60, step: 5.0) {
                        Text("Length")
                    }
                    Spacer()
                    Text("\(Int(scrumData.lengthInMinutes)) minutes")
                }
                ColorPicker("Color", selection: $scrumData.color)
            }
//            Section(header: Text("Attendees")) {
//                ForEach(scrumData.attendees, id: \.self) { attendee in
//                    Text(attendee)
//                }
//                .onDelete { indices in
//                    scrumData.attendees.remove(atOffsets: indices)
//                }
//                HStack {
//                    TextField("New Attendee", text: $newAttendee)
//                    Button(action: {
//                        withAnimation {
//                            scrumData.attendees.append(newAttendee)
//                            newAttendee = ""
//                        }
//                    }) {
//                        Image(systemName: "plus.circle.fill")
//                    }
//                    .disabled(newAttendee.isEmpty)
//                }
//            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(scrumData: .constant(DailyScrum.data[0].data))
    }
}
