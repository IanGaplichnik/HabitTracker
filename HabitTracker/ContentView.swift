//
//  ContentView.swift
//  HabitTracker
//
//  Created by MacBook on 11.8.2023.
//

import SwiftUI

class UserData: ObservableObject {
    let jsonKey = "habits"

    @Published var onboardingDone = false

    @Published var userHabits = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(userHabits) {
                UserDefaults.standard.set(encoded, forKey: jsonKey)
            }
        }
    }

    init() {
        UserDefaults.standard.removeObject(forKey: jsonKey)
        if let savedHabits = UserDefaults.standard.data(forKey: jsonKey) {
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

    var body: some View {
        if !userData.onboardingDone {
            OnboardingTabView(onboardingDone: $userData.onboardingDone, userHabits: $userData.userHabits)
        } else {
            MainHabitsListView(userData: userData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
