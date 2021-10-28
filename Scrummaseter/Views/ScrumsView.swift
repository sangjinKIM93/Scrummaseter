//
//  ScrumsView.swift
//  Scrummaseter
//
//  Created by 김상진 on 2021/09/29.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase   // 화면이 inactive 상태에 들어갔는지 확인할 수 있는 변수
    @State private var isPresented = false
    @State private var newScrumData = DailyScrum.Data()
    let saveAction: () -> Void  // 이런식으로 뷰에 closure 만들 수 있어 (delegate 대신 쓰는거지)
    
    var body: some View {
        List {
            ForEach(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: binding(for: scrum))) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.color)
            }
            .onDelete(perform: { indexSet in
                scrums.remove(atOffsets: indexSet)
            })
        }
        .navigationTitle("Habit Focus")
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }) {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $isPresented) {
            NavigationView {
                EditView(scrumData: $newScrumData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresented = false
                    }, trailing: Button("Add") {
                        let newScrum = DailyScrum(title: newScrumData.title, attendees: newScrumData.attendees, lengthInMinutes: Int(newScrumData.lengthInMinutes), color: newScrumData.color)
                        scrums.append(newScrum)
                        isPresented = false
                    })
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
    
    // 그냥 $ 붙여서 넘겨줘도 되는데, 정확하게 하려고 검증하는듯?
    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
        guard let scrumIndex = scrums.firstIndex(where: {$0.id == scrum.id}) else {
            fatalError("Can't find scrum in array")
        }
        return $scrums[scrumIndex]
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.data), saveAction: {})
        }
    }
}
