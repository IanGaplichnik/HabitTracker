//
//  DefaultHabitsSelectionView.swift
//  HabitTracker
//
//  Created by MacBook on 11.8.2023.
//

import SwiftUI

struct DefaultHabitsSelectionView: View {
    static let goalString = "Tap to edit goal"
    let defaultHabits = [
        Habit(name: "Gym", labelColor: TabColors.yellow.rawValue, complete: false, goal: goalString, imageName: "gymIcon"),
        Habit(name: "Writing", labelColor: TabColors.green.rawValue, complete: false, goal: goalString, imageName: "writingIcon"),
        Habit(name: "Water", labelColor: TabColors.blue.rawValue, complete: false, goal: goalString, imageName: "waterIcon"),
        Habit(name: "Art", labelColor: TabColors.pink.rawValue, complete: false, goal: goalString, imageName: "artsIcon"),
        Habit(name: "Fruits", labelColor: TabColors.orange.rawValue, complete: false, goal: goalString, imageName: "fruitsIcon"),
        Habit(name: "Sleep", labelColor: TabColors.gray.rawValue, complete: false, goal: goalString, imageName: "sleepIcon")
    ]
    
    @Environment(\.dismiss) var dismiss
    @Binding var userHabits: [Habit]
    @Binding var onboardingDone: Bool
    @State var selectedCardIndecies = [Int]()

    let columns = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        VStack{
            header
            scrollBody
        }
    }

    var header: some View {
        VStack {
            HStack {
                Spacer()
                Button("Skip") {
                    onboardingDone = true
                }
                .padding()
            }
            Text("Select the habits you want to improve")
                .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 28))
        }
    }

    var scrollBody: some View {
        ScrollView {
            cardGridGenerator
            continueButton
                .padding(.top, 20)
                .disabled(selectedCardIndecies.count == 0)
            Spacer()
        }
        .padding(20)
        .ignoresSafeArea()
    }

    var cardGridGenerator: some View {
        LazyVGrid(columns: columns) {
            ForEach(0..<defaultHabits.count, id: \.self) { index in
                DefaultHabitCardView(habit: defaultHabits[index], id: index, selectedCardIndecies: $selectedCardIndecies)
            }
            .padding(.vertical, 10)
        }
    }

    var continueButton: some View {
        Button {
            for index in selectedCardIndecies {
                userHabits.append(defaultHabits[index])
                sort()
            }
            onboardingDone = true
            dismiss()
        } label: {
            ButtonLabel(buttonText: "Continue",
                        buttonFont: Fonts.sfDisplayProBold.rawValue,
                        fontSize: 20,
                        buttonColor: selectedCardIndecies.count == 0 ? Color(hex: 0x8DCBFA) : Color(hex: 0x1B98F5))
        }
    }


    func sort() {
        userHabits.sort { !$0.complete && $1.complete }
    }
}

struct DefaultHabitsSelectionView_Previews: PreviewProvider {
    @State static var defaultsChosen = false
    @State static var onboardingDone = false
    @State static var userHabits = [Habit]()
    static var previews: some View {
        DefaultHabitsSelectionView(userHabits: $userHabits, onboardingDone: $onboardingDone)
    }
}
