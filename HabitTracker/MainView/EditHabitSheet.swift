//
//  EditHabitSheet.swift
//  HabitTracker
//
//  Created by MacBook on 17.8.2023.
//

import SwiftUI

struct EditHabitSheet: View {
    @State var habitName: String
    @State var goal: String
    @Binding var habits: [Habit]
    @State var colorIndex: Int
    var indexToEdit: Int


    @Environment(\.dismiss) var dismiss
    init(userHabits: Binding<[Habit]>, index: Int, userHabit: Habit) {

        _habits = userHabits
        indexToEdit = index
        _habitName = State(initialValue: userHabit.name)
        _goal = State(initialValue: userHabit.goal ?? "")
        _colorIndex = State(
            initialValue: TabColors.allColors.firstIndex(of: TabColors(rawValue: userHabit.labelColor)!)!
        )
        print(userHabit)
        print(index)
    }

    var body: some View {
        VStack(alignment: .leading) {
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
            Rectangle()
                .foregroundColor(Color(hex: 0xDBDBDB))
                .frame(height: 2)
            VStack(alignment: .leading) {
                Text("Name the habit")
                    .padding(.top)
                TextField("Yoga", text: $habitName)
                    .textFieldStyle(.roundedBorder)


                Text("Set the goal")
                    .padding(.top)
                TextField("30 minutes a day", text: $goal)
                    .textFieldStyle(.roundedBorder)
                Text("Select label color")
                    .padding(.top)
                HStack {
                    ForEach(TabColors.allColors, id: \.self) { color in
                        Button {
                            colorIndex = TabColors.allColors.firstIndex(of: color) ?? -1
                        } label: {
                            if colorIndex == TabColors.allColors.firstIndex(of: color) {
                                Circle()
                                    .foregroundColor(convertStringToColor(color: color.rawValue))
                                    .overlay(Image(systemName: "checkmark.circle")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(.black)
                                    )
                            } else {
                                Circle()
                                    .foregroundColor(convertStringToColor(color: color.rawValue))
                            }
                        }
                    }
                }
                .frame(height: 50)
            }
            .font(.custom(Fonts.sfDisplayProSemibold.rawValue, size: 16))

            Spacer()

            Button {
                let habit = Habit(name: habitName, labelColor: TabColors.allColors[colorIndex].rawValue, complete: habits[indexToEdit].complete, goal: goal, imageName: nil)
                    habits.remove(at: indexToEdit)
                    habits.insert(habit, at: indexToEdit)
                    dismiss()
            } label: {
                Text("Apply changes")
                    .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 20))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(
                        (habitName == "" || goal == "") ? Color(hex: 0x8DCBFA) : Color(hex: 0x1B98F5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled(habitName == "" || goal == "")
        }
        .padding(30)
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
