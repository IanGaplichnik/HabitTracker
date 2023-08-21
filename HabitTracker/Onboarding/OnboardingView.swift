//
//  OnboardingScreen.swift
//  HabitTracker
//
//  Created by MacBook on 11.8.2023.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct OnboardingItem: Identifiable {
    let id: Int
    let mainText: String
    let secondaryText: String
    let image: String
}

struct OnboardingPage: View {
    let onboardingPageItem: OnboardingItem

    var body: some View {
        VStack {
            Spacer()
            centralImage
            title
            Spacer()
            secondaryText
            Spacer()
            Spacer()
        }
        .padding(.horizontal, 30)
    }

    private var centralImage: some View {
        Image(onboardingPageItem.image)
            .resizable()
            .frame(maxWidth: .infinity)
            .scaledToFit()
            .mask() {
                if onboardingPageItem.id == 1 {
                    LinearGradient(colors: [.white.opacity(0), .primary], startPoint: .bottom, endPoint: .top)
                } else {
                    Color.white.opacity(1)
                }
            }
    }

    private var title: some View {
        Text(onboardingPageItem.mainText)
            .font(.custom(Fonts.sfDisplayProBold.rawValue, size: 38))
            .padding(.top, 24)
    }

   private var secondaryText: some View {
        Text(onboardingPageItem.secondaryText)
            .font(.custom(Fonts.montserratMedium.rawValue, size: 16))
            .lineSpacing(10)
            .foregroundColor(.gray)
            .padding(.top, 4)
            .multilineTextAlignment(.center)
    }
}



    struct OnboardingPage_Previews: PreviewProvider {
        @State static var pageIndex = 1
        static let items = [
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

        static var previews: some View {
            ForEach(items) { item in
                OnboardingPage(onboardingPageItem: item)
            }
            //            .preferredColorScheme(.dark)
        }
    }
