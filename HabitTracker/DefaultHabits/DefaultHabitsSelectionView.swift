//
//  DefaultHabitsSelectionView.swift
//  HabitTracker
//
//  Created by MacBook on 11.8.2023.
//

import SwiftUI

struct Habit: Codable {
    let name: String
    let labelColor: String
    let complete: Bool
    let imageName: String?
    let goal: String?
}

struct DefaultHabitsSelectionView: View {
    let defaultHabits = [
        Habit(name: "Gym", labelColor: "red", complete: false, imageName: "gymIcon", goal: nil),
        Habit(name: "Writing", labelColor: "red", complete: false, imageName: "writingIcon", goal: nil),
        Habit(name: "Water", labelColor: "red", complete: false, imageName: "waterIcon", goal: nil),
        Habit(name: "Art", labelColor: "red", complete: false, imageName: "artsIcon", goal: nil),
        Habit(name: "Fruits", labelColor: "red", complete: false, imageName: "fruitsIcon", goal: nil),
        Habit(name: "Sleep", labelColor: "red", complete: false, imageName: "sleepIcon", goal: nil)
    ]

    @Binding var defaultsChosen: Bool
    @Binding var userHabits: [Habit]
    @State var selectedCardIndecies = [Int]()

    let columns = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        VStack{
            HStack {
                Spacer()
                Button("Skip") {
                    defaultsChosen = true
                }
                .padding(.horizontal)
            }
            Spacer()
            Spacer()
            Text("Select the habits you want to improve")
                .font(.custom("SFProDisplay-Bold", size: 28))
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
                    }
                    defaultsChosen = true
                } label: {
                    Text("Continue")
                        .font(.custom("SFProDisplay-Bold", size: 20))
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
}

struct DefaultHabitsSelectionView_Previews: PreviewProvider {
    @State static var defaultsChosen = false
    @State static var userHabits = [Habit]()
    static var previews: some View {
        DefaultHabitsSelectionView(defaultsChosen: $defaultsChosen, userHabits: $userHabits)
    }
}
