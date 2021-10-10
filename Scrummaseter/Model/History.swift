//
//  History.swift
//  Scrummaseter
//
//  Created by 김상진 on 2021/10/06.
//

import SwiftUI

struct History: Identifiable, Codable {
    var id: UUID
    var attendees: [String]
    var lengthInMinutes: Int
    var date: Date
    
    init(id: UUID = UUID(), attendees: [String], lengthInMinutes: Int, date: Date = Date()) {
        self.id = id
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.date = date
    }
}
