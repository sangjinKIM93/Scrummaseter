//
//  ScrummaseterApp.swift
//  Scrummaseter
//
//  Created by 김상진 on 2021/09/25.
//

import SwiftUI

@main
struct ScrummaseterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MeetingView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
