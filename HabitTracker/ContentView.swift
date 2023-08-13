//
//  ContentView.swift
//  HabitTracker
//
//  Created by MacBook on 11.8.2023.
//

import SwiftUI

class UserData: ObservableObject {
    @Published var onboardingDone = false
    @Published var defaultsChosen = false
    @Published var userHabits = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(userHabits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }

    init() {
        UserDefaults.standard.removeObject(forKey: "Habits")
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabits) {
                userHabits = decodedHabits
                if userHabits.count != 0 {
                    onboardingDone = true
                }
                return
            }
        }
        userHabits = []
    }
}

struct ContentView: View {
    @StateObject var userData = UserData()

    @State private var currentPageIndex = 0

    var body: some View {
        if !userData.onboardingDone {
            OnboardingTabView(onboardingDone: $userData.onboardingDone)
        } else if !userData.defaultsChosen {
            DefaultHabitsSelectionView(defaultsChosen: $userData.defaultsChosen, userHabits: $userData.userHabits)
        } else {
//            MainHabitsListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
