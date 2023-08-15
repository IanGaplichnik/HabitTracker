//
//  DefaultHabitsSelectionView.swift
//  HabitTracker
//
//  Created by MacBook on 11.8.2023.
//

import SwiftUI

struct Habit: Codable, Identifiable {
    let id = UUID()
    let name: String
    let labelColor: String
    var complete: Bool
    let goal: String?
    let imageName: String?
}

struct DefaultHabitsSelectionView: View {
    let defaultHabits = [
        Habit(name: "Gym", labelColor: TabColors.yellow.rawValue, complete: false, goal: nil, imageName: "gymIcon"),
        Habit(name: "Writing", labelColor: TabColors.green.rawValue, complete: false, goal: nil, imageName: "writingIcon"),
        Habit(name: "Water", labelColor: TabColors.blue.rawValue, complete: true, goal: nil, imageName: "waterIcon"),
        Habit(name: "Art", labelColor: TabColors.pink.rawValue, complete: false, goal: nil, imageName: "artsIcon"),
        Habit(name: "Fruits", labelColor: TabColors.orange.rawValue, complete: false, goal: nil, imageName: "fruitsIcon"),
        Habit(name: "Sleep", labelColor: TabColors.gray.rawValue, complete: false, goal: nil, imageName: "sleepIcon")
    ]
    
    @Environment(\.dismiss) var dismiss
    @Binding var userHabits: [Habit]
    @Binding var onboardingDone: Bool
    @State var selectedCardIndecies = [Int]()

    let columns = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        VStack{
            Spacer()
            Spacer()
            HStack {
                Spacer()
                Button("Skip") {
                    onboardingDone = true
                }
                .padding(.horizontal)
            }
            Spacer()
            Spacer()
            Text("Select the habits you want to improve")
                .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 28))
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(0..<defaultHabits.count, id: \.self) { index in
                        DefaultHabitCard(habit: defaultHabits[index], id: index, selectedCardIndecies: $selectedCardIndecies)
                    }
                    .padding(.vertical, 10)
                }

                Button {
                    for index in selectedCardIndecies {
                        print(index)
                        userHabits.append(defaultHabits[index])
                        sort()
                    }
                    onboardingDone = true
                    dismiss()
                } label: {
                    Text("Continue")
                        .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 20))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(selectedCardIndecies.count == 0 ? Color(hex: 0x8DCBFA) : Color(hex: 0x1B98F5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.top, 20)
                .disabled(selectedCardIndecies.count == 0)
                Spacer()
            }
            .padding(20)
            .ignoresSafeArea()
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
