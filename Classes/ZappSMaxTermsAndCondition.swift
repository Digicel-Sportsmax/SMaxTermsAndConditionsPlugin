//
//  ZappSMaxTermsAndCondition.swift
//
//  Created by Mohieddine Zarif on 24/04/2020.
//  Copyright © 2020 CME. All rights reserved.
//

import Foundation
import ZappPlugins
import ApplicasterSDK

@objc public class ZappSMaxTermsAndCondition : NSObject, ZPAppLoadingHookProtocol, SportsMaxTermsBaseProtocol {

    fileprivate let sportsMaxTermsViewController = "SportsMaxTermsViewController"
    fileprivate let sportsMaxTermsStoryboard = "SMaxTermsAndConditionsStoryboard"
    private var navigationController: UINavigationController? = nil
    public var configurationJSON: NSDictionary?
    
    public required override init() {
        super.init()
    }
    
    public required init(configurationJSON: NSDictionary?) {
        super.init()
        self.configurationJSON = configurationJSON
    }
    
    public func userDidSelectToClose() {
        if let vc = navigationController?.presentingViewController{
            vc.dismiss(animated: true, completion: nil)
        }
    }
    
    func showTermsScreen(){
        let storyboard = UIStoryboard(name: self.sportsMaxTermsStoryboard, bundle: nil)

        if let termsViewController = storyboard.instantiateViewController(withIdentifier: self.sportsMaxTermsViewController) as? SportsMaxTermsViewController {
            termsViewController.delegate = self
            if let termAndConditionText = configurationJSON?["terms_condition_text"] as? String{
                termsViewController.terms_condition_text = termAndConditionText
            }
            termsViewController.modalPresentationStyle = .fullScreen
            navigationController = UINavigationController(rootViewController: termsViewController)
            if let nav = navigationController{
                APApplicasterController.sharedInstance()?.rootViewController.topmostModal()?.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    public func executeAfterAppRootPresentation(displayViewController: UIViewController?, completion: (() -> Void)?) {
        if let showScreen = configurationJSON?["show_screen_at_launch"] as? String{
            if (showScreen == "1" && !SMaxTermsAndConditionPreferencesManager.getStatusOfTermsScreen()) {
                self.showTermsScreen()
                SMaxTermsAndConditionPreferencesManager.termsScreenHasBeenShown()
            }
        }
    }
}
