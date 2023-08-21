//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by MacBook on 14.8.2023.
//

import SwiftUI

struct AddHabitSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var userHabits: [Habit]
    @State private var habitName = ""
    @State private var goal = ""
    @State private var selectedColorIndex = -1

    var body: some View {
        VStack(alignment: .leading) {
            header
            SheetBodyComponentView(habitName: $habitName,
                          goal: $goal,
                          selectedColorIndex: $selectedColorIndex)
            Spacer()
            addHabitButton
        }
        .padding(30)
    }

    private var header: some View {
        HStack {
            Text("Create new habit")
                .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 28))
            Spacer()
            Button("Cancel") {
                dismiss()
            }
        }
    }
    
    private var addHabitButton: some View {
        Button {
            let habit = Habit(name: habitName.trimmingCharacters(in: .whitespaces),
                              labelColor: TabColors.allColors[selectedColorIndex].rawValue,
                              complete: false,
                              goal: goal.trimmingCharacters(in: .whitespaces),
                              imageName: nil)
            userHabits.append(habit)
            sortComplete()
            dismiss()
        } label: {
            ButtonLabel(buttonText: "Add habit",
                        buttonFont: Fonts.sfDisplayProBold.rawValue,
                        fontSize: 20,
                        buttonColor: (habitName == "" || goal == "" || selectedColorIndex == -1) ? Color(hex: 0x8DCBFA) : Color(hex: 0x1B98F5))
        }
        .disabled(habitName == "" || goal == "" || selectedColorIndex == -1)
    }

    func sortComplete() {
        userHabits.sort { !$0.complete && $1.complete }
    }
}


struct AddHabitSheet_Previews: PreviewProvider {
    @State static var userHabits = [Habit]()
    static var previews: some View {
        NavigationView {
            Text("").sheet(isPresented: .constant(true)) {
                AddHabitSheet(userHabits: $userHabits)
            }
        }
    }
}
