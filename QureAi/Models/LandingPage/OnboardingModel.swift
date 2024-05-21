//
//  OnboardingModel.swift
//  QureAi
//
//  Created by Heeba Khan on 17/05/24.
//

import Foundation
import UIKit

struct OnboardingItem {
    let onboardingImage: UIImage?
    let onboardingText: String?
    
    // Initialize an onboarding item with an image and text
    init(onboardingImage: UIImage?, onboardingText: String?) {
        self.onboardingImage = onboardingImage
        self.onboardingText = onboardingText
    }
}

// Define an extension to provide sample onboarding items
extension OnboardingItem {
    static func onboardingSlideData() -> [OnboardingItem] {
        // For simplicity, hardcoded example data
        let item1 = OnboardingItem(onboardingImage: AppImages.onboardingImageFirst, onboardingText: AppStrings.onboardingText1)
        let item2 = OnboardingItem(onboardingImage: AppImages.onboardingImageSecond, onboardingText: AppStrings.onboardingText2)
        let item3 = OnboardingItem(onboardingImage: AppImages.onboardingImageThird, onboardingText: AppStrings.onboardingText3)
        return [item1, item2, item3]
    }
}
