//
//  ScrummaseterApp.swift
//  Scrummaseter
//
//  Created by 김상진 on 2021/09/25.
//

import SwiftUI

@main
struct ScrummaseterApp: App {
    @State private var scrums = DailyScrum.data

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
