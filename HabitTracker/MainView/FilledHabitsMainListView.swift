//
//  FilledHabitsMainListView.swift
//  HabitTracker
//
//  Created by MacBook on 20.8.2023.
//

import SwiftUI

struct FilledHabitsMainListView: View {
    class HabitToEditWrapper {
        var habit: Habit?
        var indexInDataBase: Int

        init() {
            indexInDataBase = -1
            habit = nil
            return
        }
    }

    @Binding var addHabitSheetShowing: Bool
    @Binding var editHabitSheetShowing: Bool
    @Binding var userHabits: [Habit]

    let habitWrapper = HabitToEditWrapper()

    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    Spacer()
                    HeaderTextDateDivider()
                    scrollWithHabits
                }
                .padding(.horizontal, 30)
                floatingActionButton
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $editHabitSheetShowing) {
            EditHabitSheet(userHabits: $userHabits,
                           index: self.habitWrapper.indexInDataBase,
                           userHabit: self.habitWrapper.habit!)
        }
    }

    private var scrollWithHabits: some View {
        ScrollView {
            ForEach($userHabits) { $habit in
                Button(action: {
                    self.habitWrapper.habit = habit
                    self.habitWrapper.indexInDataBase = userHabits.firstIndex(of: habit)!
                    editHabitSheetShowing = true
                }) {
                    MainViewCard(habits: $userHabits, habit: $habit)
                        .padding(.vertical, 3)
                        .shadow(color: .gray, radius: 2, x: 2, y: 2)
                }
            }
        }
    }

    private var floatingActionButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button{
                    addHabitSheetShowing = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(Color(hex: 0x1B98F5))
                        .shadow(color: .gray, radius: 2, x: 2, y: 2)
                        .padding(.horizontal, 30)
                }
            }
        }
    }
}

struct FilledHabitsMainListView_Previews: PreviewProvider {
    @State static var editShowing = false
    @State static var addShowing = false
    @State static var habits = [
        Habit(name: "Gym", labelColor: TabColors.yellow.rawValue, complete: false, goal: "test", imageName: "gymIcon"),
        Habit(name: "Writing", labelColor: TabColors.green.rawValue, complete: false, goal: "test", imageName: "writingIcon"),
        Habit(name: "Water", labelColor: TabColors.blue.rawValue, complete: true, goal: "test", imageName: "waterIcon"),
        Habit(name: "Waas", labelColor: TabColors.blue.rawValue, complete: true, goal: "test", imageName: "waterIcon")
    ]
    
    static var previews: some View {
        FilledHabitsMainListView(addHabitSheetShowing: $addShowing,
                                 editHabitSheetShowing: $editShowing,
                                 userHabits: $habits)

    }
}
