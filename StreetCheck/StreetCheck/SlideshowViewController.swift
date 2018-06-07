//
//  SlideshowViewController.swift
//  
//
//  Created by Presley Reed III on 6/6/18.
//

import UIKit
import paper_onboarding

class SlideshowViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    @IBOutlet weak var slideshowView: SlideshowView!
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideshowView.dataSource = self
        slideshowView.delegate = self

        // Do any additional setup after loading the view.
    }


    func onboardingItemsCount() -> Int {
        return 4
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let backgroundColor1 = UIColor(red: 33.0/255.0, green: 114.0/255.0, blue: 236.0/255.0, alpha: 1.0)
        let backgroundColor2 = UIColor(red: 25.0/255.0, green: 95.0/255.0, blue: 217.0/255.0, alpha: 1.0)
        let backgroundColor3 = UIColor(red: 19.0/255.0, green: 71.0/255.0, blue: 148.0/255.0, alpha: 1.0)
        let backgroundColor4 = UIColor(red: 14.0/255.0, green: 55.0/255.0, blue: 107.0/255.0, alpha: 1.0)
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)
        
        return [OnboardingItemInfo(informationImage: UIImage(named: "Clear Logo")!, title: "Welcome to Street Check", description: "A recording keeping app for law enforcement agents.", pageIcon: UIImage(named: "circle")!, color: backgroundColor1, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont!), OnboardingItemInfo(informationImage: UIImage(named: "singleWhite")!, title: "Individuals", description: "Keep a record of the individuals that you arrest with robust and homogenous data.", pageIcon: UIImage(named: "circle")!, color: backgroundColor2, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont!), OnboardingItemInfo(informationImage: UIImage(named: "groupWhite")!, title: "Group", description: "Maintain data on groups of individuals who work together.", pageIcon: UIImage(named: "circle")!, color: backgroundColor3, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont!), OnboardingItemInfo(informationImage: UIImage(named: "lockWhite")!, title: "Security", description: "Keep the app secure by creating a secure password.", pageIcon: UIImage(named: "circle")!, color: backgroundColor4, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont!)][index]
    }
    
    func onboardingConfigurationItem(_: OnboardingContentViewItem, index _: Int) {
        
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 2 {
            if self.getStartedButton.alpha == 1{
                UIView.animate(withDuration: 0.2, animations: {
                    self.getStartedButton.alpha = 0
                    })
            }
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 3{
            UIView.animate(withDuration: 0.4, animations: {
                self.getStartedButton.alpha = 1
                })
        }
    }
    
    
}
