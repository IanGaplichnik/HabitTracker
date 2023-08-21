//
//  EditHabitSheet.swift
//  HabitTracker
//
//  Created by MacBook on 17.8.2023.
//

import SwiftUI

struct EditHabitSheet: View {
    @Environment(\.dismiss) var dismiss
    @State var habitName: String
    @State var goal: String
    @Binding var habits: [Habit]
    @State var colorIndex: Int
    
    var indexToEdit: Int

    init(userHabits: Binding<[Habit]>, index: Int, userHabit: Habit) {

        _habits = userHabits
        indexToEdit = index
        _habitName = State(initialValue: userHabit.name)
        _goal = State(initialValue: userHabit.goal)
        _colorIndex = State(
            initialValue: TabColors.allColors.firstIndex(of: TabColors(rawValue: userHabit.labelColor)!)!
        )
        print(userHabit)
        print(index)
    }

    var body: some View {
        VStack(alignment: .leading) {
            header
            SheetBodyComponentView(habitName: $habitName,
                                   goal: $goal,
                                   selectedColorIndex: $colorIndex)
            Spacer()
            applyChangesButton
        }
        .padding(30)
    }

    private var applyChangesButton: some View {
        Button {
            let habit = Habit(name: habitName, labelColor: TabColors.allColors[colorIndex].rawValue, complete: habits[indexToEdit].complete, goal: goal, imageName: nil)
            habits.remove(at: indexToEdit)
            habits.insert(habit, at: indexToEdit)
            dismiss()
        } label: {
            ButtonLabel(buttonText: "Apply changes",
                        buttonFont: Fonts.sfDisplayProBold.rawValue,
                        fontSize: 20,
                        buttonColor: (habitName == "" || goal == "") ? Color(hex: 0x8DCBFA) : Color(hex: 0x1B98F5))
        }
        .disabled(habitName == "" || goal == "")
    }

    private var header: some View {
        HStack {
            Button {
                habits.remove(at: indexToEdit)
                dismiss()
            } label: {
                Text("Delete")
                    .foregroundColor(.red)
            }
            Spacer()
            Text("Edit Habit")
                .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 28))
            Spacer()
            Button("Cancel") {
                dismiss()
            }
        }
    }

    struct EditHabitSheet_Previews: PreviewProvider {
        @State static var userHabits = [Habit(name: "gyn", labelColor: TabColors.pink.rawValue, complete: false, goal: "aksjd", imageName: nil)]
        static var previews: some View {
            NavigationView {
                Text("").sheet(isPresented: .constant(true)) {
                    EditHabitSheet(userHabits: $userHabits, index: 0, userHabit: userHabits[0])
                }
            }
        }
    }
}
