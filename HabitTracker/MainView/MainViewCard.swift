//
//  MainViewCard.swift
//  HabitTracker
//
//  Created by MacBook on 14.8.2023.
//

import SwiftUI

struct MainViewCard: View {
    @Binding var habits: [Habit]
    @Binding var habit: Habit

    var body: some View {
        HStack {
            buttonText
                .padding()
            Spacer()
            if habit.complete {
               completeButtonWithImage
            } else {
               notCompleteButtonWithImage
            }
        }
        .background(habit.complete ? Color(hex: 0xF8F8F8) : convertStringToColor(color: habit.labelColor))
        .cornerRadius(10)
    }

    var buttonText: some View {
        VStack(alignment: .leading) {
            Text(habit.name)
                .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 24))
                .padding(.bottom, 1)
                .foregroundColor(habit.complete ? Color(hex: 0x03A744) : .primary)
            Text(habit.goal)
                .font(.custom(Fonts.montserratMedium.rawValue, size: 14))
                .foregroundColor(habit.complete ? Color(hex: 0x03A744) : .secondary)
        }
    }

    var completeButtonWithImage: some View {
        Button {
            habit.complete = false
            sort()
        } label: {
            Image("completeHabit")
                .resizable()
                .scaledToFit()
                .foregroundColor(habit.complete ? Color(hex: 0x03A744) : .white)
                .frame(height: 80)
                .cornerRadius(habit.complete ? 0 : 40)
                .padding(.horizontal, 7)
        }
    }

    var notCompleteButtonWithImage: some View {
        Button {
            habit.complete = true
            sort()
        } label: {
            Image(systemName: "circle")
                .resizable()
                .background(Color(hex: 0xEAEAEA))
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .cornerRadius(40)
                .padding()
        }
    }

    func sort() {
        habits.sort { !$0.complete && $1.complete }
    }
    
}

struct MainViewCard_Previews: PreviewProvider {
    @State static var habitGoal = [Habit(name: "Gym", labelColor: TabColors.yellow.rawValue, complete: false, goal: "2 times a day", imageName: "gymIcon")]

    @State static var doneGoal = [Habit(name: "Gym", labelColor: TabColors.yellow.rawValue, complete: true, goal: "2 times a day", imageName: "gymIcon")]

    static var previews: some View {
        MainViewCard(habits: $habitGoal, habit: $habitGoal[0])
        MainViewCard(habits: $doneGoal, habit: $doneGoal[0])
    }
}
