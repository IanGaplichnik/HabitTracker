//
//  SheetBodyComponentView.swift
//  HabitTracker
//
//  Created by MacBook on 21.8.2023.
//

import SwiftUI

struct SheetBodyComponentView: View {
    @Binding var habitName: String
    @Binding var goal: String
    @Binding var selectedColorIndex: Int

    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(Color(hex: 0xDBDBDB))
                .frame(height: 2)
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
            labelColorSelector
                .frame(height: 50)
        }
        .font(.custom(Fonts.sfDisplayProSemibold.rawValue, size: 16))
    }

    var labelColorSelector: some View {
        HStack {
            ForEach(TabColors.allColors, id: \.self) { color in
                Button {
                    selectedColorIndex = TabColors.allColors.firstIndex(of: color) ?? -1
                } label: {
                    Circle()
                        .foregroundColor(convertStringToColor(color: color.rawValue))
                        .if(selectedColorIndex == TabColors.allColors.firstIndex(of: color)) { view in
                            view.overlay(Image(systemName: "checkmark.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.black)
                            )
                        }
                }
            }
        }
    }
}


struct SheetBodyComponentView_Previews: PreviewProvider {
    @State static var habitName = "Habit name"
    @State static var goal = "Goal"
    @State static var selectedColorIndex = -1

    static var previews: some View {
        SheetBodyComponentView(habitName: $habitName, goal: $goal, selectedColorIndex: $selectedColorIndex)
    }
}
