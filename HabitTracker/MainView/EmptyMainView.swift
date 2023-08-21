//
//  EmptyMainView.swift
//  HabitTracker
//
//  Created by MacBook on 20.8.2023.
//

import SwiftUI

struct EmptyHabitsMainListView: View {
    @Binding var addHabitShowing: Bool
    
    var body: some View {
        VStack{
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
                ButtonLabel(buttonText: "Create new habit",
                            buttonFont: Fonts.sfDisplayProBold.rawValue,
                            fontSize: 20,
                            buttonColor: Color(hex: 0x1B98F5))
            }
            .padding()
        }
        .padding(.horizontal, 30)
        .frame(maxHeight: .infinity)
    }
}

struct EmptyHabitsMainListView_Previews: PreviewProvider {
    @State static var addHabit = false
    @State static var emptyData: UserData = {
        let data = UserData()
        data.userHabits = []
        return data
    }()
    
    static var previews: some View {
        EmptyHabitsMainListView(addHabitShowing: $addHabit)
    }
}
