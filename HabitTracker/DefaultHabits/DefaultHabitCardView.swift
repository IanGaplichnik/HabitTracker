//
//  DefaultHabitCard.swift
//  HabitTracker
//
//  Created by MacBook on 11.8.2023.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

func convertStringToColor(color: String) -> Color {
    switch color {
    case TabColors.yellow.rawValue:
        return Color(hex: 0xF3CE6D)
    case TabColors.green.rawValue:
        return Color(hex: 0x57CEBB)
    case TabColors.blue.rawValue:
        return Color(hex: 0x5CD3F3)
    case TabColors.pink.rawValue:
        return Color(hex: 0xDF9CC7)
    case TabColors.orange.rawValue:
        return Color(hex: 0xFFAD5F)
    case TabColors.gray.rawValue:
        return Color(hex: 0x9EB5C5)
    default:
        return Color(hex: 0x000000)
    }
}

struct DefaultHabitCardView: View {
    @Environment(\.colorScheme) var colorScheme

    let habit: Habit
    let id: Int
    @State private var isSelected: Bool = false
    @Binding var selectedCardIndecies: [Int]

    var body: some View {
        Button {
            withAnimation(.default) {
                isSelected.toggle()
            }
            if let index = selectedCardIndecies.firstIndex(of: id) {
                selectedCardIndecies.remove(at: index)
            } else {
                selectedCardIndecies.append(id)
            }
        } label: {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image(systemName: isSelected ? "checkmark.circle" : "circle")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(Color(.black))
                        .background(.white)
                        .cornerRadius(50)
                        .padding(.horizontal, 14)
                        .padding(.top, 14)
                }
                Image(habit.imageName ?? "sleepIcon")
                    .resizable()
                    .scaledToFit()
                Text(habit.name)
                    .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 24))
                    .foregroundColor(.black)
                    .padding(.top, 7)
                    .padding(.horizontal, 14)
                    .padding(.bottom, 14)
            }
        }
        .background(convertStringToColor(color: habit.labelColor))
        .frame(width: 154)
        .cornerRadius(10)
        .if(!isSelected && colorScheme == .light) { view in
            view.shadow(color: Color(hex: 0x7D7D7D), radius: 3, x: 0, y: 4)
        }
    }
}

struct DefaultHabitCardView_Previews: PreviewProvider {
    static var habit = Habit(name: "Gym", labelColor: TabColors.orange.rawValue, complete: false, goal: "test", imageName: "gymIcon")
//    @StateObject static var selectedHabits = SelectedCardIndecies()
    @State static var indecies = [Int]()
    static var previews: some View {
        DefaultHabitCardView(habit: habit, id: 1, selectedCardIndecies: $indecies)
    }
}
