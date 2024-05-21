//
//  LandingPageCollectionViewCell.swift
//  QureAi
//
//  Created by Heeba Khan on 17/05/24.
//

import UIKit

class LandingPageCollectionViewCell: UICollectionViewCell {
    
    //MARK: OUTLETS
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var onboardingImage: UIImageView!
    @IBOutlet weak var onboardingTextLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureOnboardingCell()
    }
    
    private func configureOnboardingCell(){
        self.bgView.backgroundColor = .clear
        self.onboardingTextLabel.font = UIFont.customFont(.text, size: 16)
        self.onboardingTextLabel.numberOfLines = 0
        self.onboardingTextLabel.textColor = UIColor.gray1
        self.onboardingImage.contentMode = .scaleAspectFit
        self.onboardingTextLabel.textAlignment = .center
    }
    
     func setDataInCell(onboardingModel: OnboardingItem){
        self.onboardingImage.image = onboardingModel.onboardingImage
        self.onboardingTextLabel.text = onboardingModel.onboardingText
    }

}
