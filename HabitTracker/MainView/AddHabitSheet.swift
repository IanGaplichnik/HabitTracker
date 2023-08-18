//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by MacBook on 14.8.2023.
//

import SwiftUI

struct AddHabitSheet: View {
    func sortComplete() {
        userHabits.sort { !$0.complete && $1.complete }
    }


    @Binding var userHabits: [Habit]

    @Environment(\.dismiss) var dismiss
    @State private var habitName = ""
    @State private var goal = ""
    @State private var selectedColor = -1

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Create new habit")
                    .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 28))
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                //                .padding(.horizontal)
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
                            selectedColor = TabColors.allColors.firstIndex(of: color) ?? -1
                        } label: {
                            if selectedColor == TabColors.allColors.firstIndex(of: color) {
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
                let habit = Habit(name: habitName.trimmingCharacters(in: .whitespaces),
                                  labelColor: TabColors.allColors[selectedColor].rawValue,
                                  complete: false,
                                  goal: goal.trimmingCharacters(in: .whitespaces),
                                  imageName: nil)
                userHabits.append(habit)
                sortComplete()
                dismiss()
            } label: {
                Text("Add habit")
                    .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 20))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(
                        (habitName == "" || goal == "" || selectedColor == -1) ? Color(hex: 0x8DCBFA) : Color(hex: 0x1B98F5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled(habitName == "" || goal == "" || selectedColor == -1)
        }
        .padding(30)
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
}
