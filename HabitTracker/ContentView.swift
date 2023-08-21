//
//  ContentView.swift
//  HabitTracker
//
//  Created by MacBook on 11.8.2023.
//

import SwiftUI

enum TabColors : String {
     case yellow = "yellow", green = "green", blue = "blue", pink = "pink", orange = "orange", gray = "gray"

     static let allColors = [yellow, green, blue, pink, orange, gray]
}

enum Fonts: String {
    case sfDisplayProBold = "SFProDisplay-Bold"
    case sfDisplayProSemibold = "SFProDisplay-Semibold"
    case montserratMedium = "Montserrat-Medium"
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
