//
//  MainHabitsListView.swift
//  HabitTracker
//
//  Created by MacBook on 13.8.2023.
//

import SwiftUI

struct MainHabitsListView: View {
    @ObservedObject var userData: UserData

    var body: some View {
        ForEach(0..<userData.userHabits.count, id: \.self) { i in
            Text(userData.userHabits[i].name)
        }
    }
}

struct MainHabitsListView_Previews: PreviewProvider {
    @ObservedObject static var userData = UserData()

    static var previews: some View {
        MainHabitsListView(userData: userData)
    }
}
