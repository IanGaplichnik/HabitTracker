//
//  MainHabitsListView.swift
//  HabitTracker
//
//  Created by MacBook on 13.8.2023.
//

import SwiftUI

struct MainHabitsListView: View {
    @ObservedObject var userData: UserData
    @State private var addHabitShowing = false

    struct EmptyHabitView: View {
        @Binding var addHabitShowing: Bool

        var body: some View {
            Spacer()
            Image("emptyHabitListMainView")
                .padding()
            Text("No habits yet...")
                .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 38))
            Text("The best time to start is now!")
                .foregroundColor(.secondary)
                .font(.custom(Fonts.montserratMedium.rawValue, size: 16))
            Spacer()
            Button {
                addHabitShowing = true
            } label: {
                Text("Create new habit")
                    .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 20))
                    .foregroundColor(.white)
                    .background(Color(hex: 0x1B98F5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    HStack {
                        Text("All Habits")
                            .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 28))
                        Spacer()
                        Text(Date(), format: Date.FormatStyle().day().month())
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 30)
                    Rectangle()
                        .foregroundColor(Color(hex: 0xDBDBDB))
                        .frame(height: 2)
                        .padding(.horizontal, 30)
                    if userData.userHabits.count != 0 {
                        ScrollView{
                            ForEach($userData.userHabits) { $habit in
                                Button {
                                    withAnimation {
                                        habit.complete.toggle()
                                        sort()
                                    }
                                } label: {
                                    MainViewCard(habit: habit)
                                        .padding(.vertical, 3)
                                        .shadow(color: .gray, radius: 2, x: 2, y: 2)
                                        .padding(.horizontal, 30)
                                }
                            }
                        }
                    } else {
                        EmptyHabitView(addHabitShowing: $addHabitShowing)
                    }
                }
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Button{
                            addHabitShowing = true
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
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $addHabitShowing) {
            AddHabitView(userHabits: $userData.userHabits)
        }
    }

    func sort() {
        userData.userHabits.sort { !$0.complete && $1.complete }
    }
}

struct MainHabitsListView_Previews: PreviewProvider {
    static var userData: UserData = {
        let data = UserData()
        data.userHabits = [
            Habit(name: "Gym", labelColor: TabColors.yellow.rawValue, complete: false, goal: nil, imageName: "gymIcon"),
            Habit(name: "Writing", labelColor: TabColors.green.rawValue, complete: false, goal: nil, imageName: "writingIcon"),
            Habit(name: "Water", labelColor: TabColors.blue.rawValue, complete: true, goal: "lsls", imageName: "waterIcon"),
        ]
        return data
    }()

    static var previews: some View {
        MainHabitsListView(userData: userData)
        //        MainHabitsListView(userData: emptyData)
    }
}
