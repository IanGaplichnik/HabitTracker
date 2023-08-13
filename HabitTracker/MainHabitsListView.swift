//
//  MainHabitsListView.swift
//  HabitTracker
//
//  Created by MacBook on 13.8.2023.
//

import SwiftUI

struct MainHabitsListView: View {
    //    @ObservedObject var userData: UserData

    var body: some View {
        //        ForEach(0..<userData.userHabits.count) { i in
        //            Text(userData.userHabits[i].name)
        EmptyView()
    }
}

struct MainHabitsListView_Previews: PreviewProvider {
    static var userData = UserData()
    
    static var previews: some View {
        MainHabitsListView()
    }
}
