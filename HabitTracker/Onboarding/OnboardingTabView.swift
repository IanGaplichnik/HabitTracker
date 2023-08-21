//
//  OnboardingTabView.swift
//  HabitTracker
//
//  Created by MacBook on 11.8.2023.
//

import SwiftUI

struct ButtonLabel: View {
    let buttonText: String
    let buttonFont: String
    let fontSize: CGFloat
    let buttonColor: Color

    var body: some View {
        Text(buttonText)
            .font(.custom(buttonFont, size: fontSize))
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(buttonColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct OnboardingTabView: View {
    @State private var currentPageIndex = 0
    @State private var sheetIsShowing = false
    @Binding var onboardingDone: Bool
    @Binding var userHabits: [Habit]

    let items = [
        OnboardingItem(id: 0,
                       mainText: "Habbit Tracker",
                       secondaryText: "Become better every day by setting the goals and tracking your habits",
                       image: "onboardingScreenImage1"),
        OnboardingItem(id: 1,
                       mainText: "No limits",
                       secondaryText: "You can pick a goal we have prepared for you or make your own!",
                       image: "onboardingScreenImage2"),
        OnboardingItem(id: 2,
                       mainText: "Never miss a thing",
                       secondaryText: "Simple yet effective UI helps you to mark completed tasks!",
                       image: "onboardingScreenImage3")
    ]

    var body: some View {
        VStack {
            TabView(selection: $currentPageIndex) {
                ForEach(items) { item in
                    OnboardingPage(onboardingPageItem: item)
                        .tag(item.id)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                setupColor()
            }
            onboardingButton
        }
    }

    var onboardingButton: some View {
        Button() {
            withAnimation {
                if currentPageIndex == items.count - 1 {
                    sheetIsShowing = true
                } else {
                    currentPageIndex += 1
                }
            }
        } label: {
            ButtonLabel(buttonText: currentPageIndex < items.count - 1 ? "Continue" : "Get Started",
                        buttonFont: Fonts.sfDisplayProBold.rawValue,
                        fontSize: 20,
                        buttonColor: Color(hex: 0x1B98F5))
        }
        .padding(.horizontal, 30)
        .padding(.vertical)
        .sheet(isPresented: $sheetIsShowing) {
            DefaultHabitsSelectionView(userHabits: $userHabits, onboardingDone: $onboardingDone)
        }
    }

    func setupColor() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.label
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray
    }
}

struct OnboardingTabView_Previews: PreviewProvider {
    @State static var onboardingDone = false
    @State static var userHabits = [Habit]()
    static var previews: some View {
        OnboardingTabView(onboardingDone: $onboardingDone, userHabits: $userHabits)
        //            .preferredColorScheme(.dark)
    }
}
