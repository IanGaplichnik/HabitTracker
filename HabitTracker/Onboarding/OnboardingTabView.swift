//
//  OnboardingTabView.swift
//  HabitTracker
//
//  Created by MacBook on 11.8.2023.
//

import SwiftUI

struct OnboardingTabView: View {
    struct OnboardingButton: View {
        @Binding var currentPageIndex: Int
        @Binding var onboardingDone: Bool
        var itemsCount: Int

        var body: some View {
            Button() {
                withAnimation {
                    if currentPageIndex == itemsCount - 1 {
                        onboardingDone = true
                    } else {
                        currentPageIndex += 1
                    }
                }
            } label: {
                Text(currentPageIndex < itemsCount - 1 ? "Continue" : "Get Started")
                    .font(.custom("SFProDisplay-Bold", size: 20))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color(hex: 0x1B98F5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
        }
    }

    @State private var currentPageIndex = 0
    @Binding var onboardingDone: Bool

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
                    OnboardingPage(onboardingPageItem: item, pageIndex: $currentPageIndex)
                        .tag(item.id)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                setupColor()
            }
            OnboardingButton(currentPageIndex: $currentPageIndex, onboardingDone: $onboardingDone, itemsCount: items.count)
        }
    }

    func setupColor() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.label
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray
    }
}

struct OnboardingTabView_Previews: PreviewProvider {
    @State static var onboardingDone = false
    static var previews: some View {
        OnboardingTabView(onboardingDone: $onboardingDone)
//            .preferredColorScheme(.dark)
    }
}
