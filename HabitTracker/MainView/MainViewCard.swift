//
//  MainViewCard.swift
//  HabitTracker
//
//  Created by MacBook on 14.8.2023.
//

import SwiftUI

struct MainViewCard: View {
//    @State 
    let habit: Habit

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(habit.name)
                    .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 24))
                    .padding(.bottom, 1)
                    .foregroundColor(habit.complete ? Color(hex: 0x03A744) : .primary)
                Text(habit.goal ?? "Goal?")
                    .font(.custom("Montseratt-Medium", size: 14))
                    .foregroundColor(habit.complete ? Color(hex: 0x03A744) : .secondary)
            }
            .padding()
            Spacer()
            if habit.complete {
                Image("completeHabit")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(habit.complete ? Color(hex: 0x03A744) : .white)
                    .frame(height: 80)
                    .cornerRadius(habit.complete ? 0 : 40)
                    .padding(.horizontal, 7)
            } else {
                Image(systemName: "circle")
                    .resizable()
                    .background(Color(hex: 0xEAEAEA))
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .cornerRadius(40)
                    .padding()
            }
        }
        .background(habit.complete ? Color(hex: 0xF8F8F8) : convertStringToColor(color: habit.labelColor))
        .cornerRadius(10)
    }
}

struct MainViewCard_Previews: PreviewProvider {
    static var habitGoal = Habit(name: "Gym", labelColor: "yellow", complete: false, goal: "2 times a day", imageName: "gymIcon")

    static var doneGoal = Habit(name: "Gym", labelColor: "yellow", complete: true, goal: "2 times a day", imageName: "gymIcon")

    static var previews: some View {
        MainViewCard(habit: habitGoal)
//        MainViewCard(habit: doneGoal)
    }
}
