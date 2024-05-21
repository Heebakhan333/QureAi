//
//  LandingPageViewModel.swift
//  QureAi
//
//  Created by Heeba Khan on 21/05/24.
//

import Foundation
import UIKit

protocol LandingPageViewModelProtocol {
    associatedtype ItemType // Define the type of items to be displayed
    var items: [ItemType] { get }
    
    func fetchItems()
}

// Example ViewModel implementation
class LandingPageViewModel: LandingPageViewModelProtocol {
    typealias ItemType = OnboardingItem
    
    var items: [OnboardingItem] = []
   // let model = OnboardingItem()
    
    func fetchItems() {
        // Fetch items using the model
        items = OnboardingItem.onboardingSlideData()
    }
}
