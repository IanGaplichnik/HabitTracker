//
//  MainHabitsListView.swift
//  HabitTracker
//
//  Created by MacBook on 13.8.2023.
//

import SwiftUI

struct HeaderTextDateDivider: View {
    var body: some View {
        HStack {
            Text("Habit Tracker")
                .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 28))
            Spacer()
            Text(Date(), format: Date.FormatStyle().day().month())
                .foregroundColor(.secondary)
        }
        Rectangle()
            .foregroundColor(Color(hex: 0xDBDBDB))
            .frame(height: 2)
    }
}


struct MainHabitsListView: View {
    @ObservedObject var userData: UserData
    @State var addHabitSheetShowing = false
    @State var editHabitSheetShowing = false
    @State var move = false
    
    var body: some View {
        VStack {
            if userData.userHabits.count == 0 {
                EmptyHabitsMainListView(addHabitShowing: $addHabitSheetShowing)
            } else {
                FilledHabitsMainListView(addHabitSheetShowing: $addHabitSheetShowing,
                                         editHabitSheetShowing: $editHabitSheetShowing,
                                         userHabits: $userData.userHabits)
            }
        }
        .sheet(isPresented: $addHabitSheetShowing) {
            AddHabitSheet(userHabits: $userData.userHabits)
        }
    }
}

struct MainHabitsListView_Previews: PreviewProvider {
    static var userData: UserData = {
        let data = UserData()
        data.userHabits = [
            Habit(name: "Gym", labelColor: TabColors.yellow.rawValue, complete: false, goal: "test", imageName: "gymIcon"),
            Habit(name: "Writing", labelColor: TabColors.green.rawValue, complete: false, goal: "test", imageName: "writingIcon"),
            Habit(name: "Water", labelColor: TabColors.blue.rawValue, complete: true, goal: "test", imageName: "waterIcon"),
            Habit(name: "Waas", labelColor: TabColors.blue.rawValue, complete: true, goal: "test", imageName: "waterIcon")
        ]
        return data
    }()

    static var previews: some View {
        MainHabitsListView(userData: userData)
    }
}
