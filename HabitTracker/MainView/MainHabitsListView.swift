//
//  MainHabitsListView.swift
//  HabitTracker
//
//  Created by MacBook on 13.8.2023.
//

import SwiftUI

struct MainHabitsListView: View {
    class HabitToEditWrapper {
        var habit: Habit?
        var indexInDataBase: Int

        init() {
            indexInDataBase = -1
            habit = nil
            return
        }
    }

    @ObservedObject var userData: UserData
    @State var addHabitShowing = false
    @State var editHabitShowing = false
    let habitWrapper = HabitToEditWrapper()

    struct EmptyHabitView: View {
        @Binding var addHabitShowing: Bool

        var body: some View {
            VStack{
                Spacer()
                Image("emptyHabitListMainView")
                    .padding()
//                                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color(hex: 0x1B98F5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal, 30)
            .frame(maxHeight: .infinity)
        }
    }

    struct FloatingActionButton: View {
        @Binding var addHabitShowing: Bool

        var body: some View {
            VStack {
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
    }

    @State var move = false
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    Spacer()
                    HStack {
                        Text("Habit Tracker")
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
                        ScrollView {
                            ForEach($userData.userHabits) { $habit in
                                Button(action: {
                                    self.habitWrapper.habit = habit
                                    self.habitWrapper.indexInDataBase = userData.userHabits.firstIndex(of: habit)!
                                    editHabitShowing = true
                                }) {
                                    MainViewCard(habits: $userData.userHabits, habit: $habit)
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
                if userData.userHabits.count != 0 {
                    FloatingActionButton(addHabitShowing: $addHabitShowing)
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $addHabitShowing) {
            AddHabitSheet(userHabits: $userData.userHabits)
        }
        .sheet(isPresented: $editHabitShowing) {
            EditHabitSheet(userHabits: $userData.userHabits,
                           index: self.habitWrapper.indexInDataBase,
                           userHabit: self.habitWrapper.habit!)
        }
    }
}

struct MainHabitsListView_Previews: PreviewProvider {
    static var userData: UserData = {
        let data = UserData()
        data.userHabits = [
            Habit(name: "Gym", labelColor: TabColors.yellow.rawValue, complete: false, goal: "jhgk", imageName: "gymIcon"),
            Habit(name: "Writing", labelColor: TabColors.green.rawValue, complete: false, goal: nil, imageName: "writingIcon"),
            Habit(name: "Water", labelColor: TabColors.blue.rawValue, complete: true, goal: "lsls", imageName: "waterIcon"),
            Habit(name: "Waas", labelColor: TabColors.blue.rawValue, complete: true, goal: "lsls", imageName: "waterIcon")
        ]
        return data
    }()

    static var emptyData: UserData = {
        let data = UserData()
        data.userHabits = []
        return data
    }()

    static var previews: some View {
        MainHabitsListView(userData: userData)
        MainHabitsListView(userData: emptyData)
    }
}
