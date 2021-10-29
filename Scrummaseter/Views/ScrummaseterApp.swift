//
//  ScrummaseterApp.swift
//  Scrummaseter
//
//  Created by 김상진 on 2021/09/25.
//

import SwiftUI

@main
struct ScrummaseterApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    @ObservedObject private var data = ScrumData()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $data.scrums) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
        .onChange(of: scenePhase, perform: { newPhase in
            if newPhase == .inactive {
                print("inactive")
            } else if newPhase == .active {
                print("active")
            } else if newPhase == .background {
                if DidUserPressLockButton() {
                    print("Lock Button - Background")
                } else {
                    print("Home Button - Background")
                }
            }
        })
    }
    
    // screen 밝기를 바꿔보고 바뀌는지 확인하는 로직이다.
    // 만약 Lock 버튼으로 바꾼거라면 bright를 바꿔도 바뀌지 않겠지?
    private func DidUserPressLockButton() -> Bool {
        let oldBrightness = UIScreen.main.brightness
        UIScreen.main.brightness = oldBrightness + (oldBrightness <= 0.01 ? (0.01) : (-0.01))
        return oldBrightness != UIScreen.main.brightness
    }
}
