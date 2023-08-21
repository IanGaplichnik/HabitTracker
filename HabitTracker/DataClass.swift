//
//  DataClass.swift
//  HabitTracker
//
//  Created by MacBook on 20.8.2023.
//

import Foundation

struct Habit: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let labelColor: String
    var complete: Bool
    let goal: String
    let imageName: String?
}

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
