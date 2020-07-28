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
    fileprivate static let termsScreenKey = "termsAndConditionScreenHasBeenShown"

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
        if let vc = navigationController?.presentingViewController {
            SMaxTermsAndConditionPreferencesManager.sharedInstance.setBool(true, forKey: ZappSMaxTermsAndCondition.self.termsScreenKey)
            vc.dismiss(animated: true, completion: nil)
        }
    }

    func showTermsScreen() {
        let storyboard = UIStoryboard(name: self.sportsMaxTermsStoryboard, bundle: nil)

        if let termsViewController = storyboard.instantiateViewController(withIdentifier: self.sportsMaxTermsViewController) as? SportsMaxTermsViewController {
            termsViewController.delegate = self

            if let termAndConditionText = configurationJSON?["terms_condition_text"] as? String {
                termsViewController.terms_condition_text = termAndConditionText
            }
            
            if let dataConsentText = configurationJSON?["data_consent_text"] as? String {
                termsViewController.data_consent_text = dataConsentText
            }

            if let navHeaderImage = configurationJSON?["navigation_header_image"] as? String {
                termsViewController.navHeaderImage = navHeaderImage
            }

            if let navHeaderText = configurationJSON?["navigation_header_text"] as? String {
                termsViewController.navHeaderText = navHeaderText
            }

            if let navBarBackgroundColor = configurationJSON?["navigation_header_background"] as? String {
                termsViewController.navBarBackgroundColor = navBarBackgroundColor
            }

            if let agreeButtonText = configurationJSON?["agree_button_text"] as? String {
                termsViewController.agreeButtonText = agreeButtonText
            }

            if let nextButtonText = configurationJSON?["next_button_text"] as? String {
                termsViewController.nextButtonText = nextButtonText
            }
            
            if let agreeButtonTextColor = configurationJSON?["agree_button_text_color"] as? String {
                termsViewController.agreeButtonTextColor = agreeButtonTextColor
            }

            
            if let agreeButtonBackgroundColor = configurationJSON?["agree_button_bg_color"] as? String {
                termsViewController.agreeButtonBackgroundColor = agreeButtonBackgroundColor
            }
            
            if let termsAndConditionCheckboxTxt = configurationJSON?["terms_and_condition_checkbox"] as? String {
                termsViewController.termsAndConditionCheckboxText = termsAndConditionCheckboxTxt
            }
            
            if let dataConsentCheckboxTxt = configurationJSON?["data_consent_checkbox"] as? String {
                termsViewController.dataConsentCheckboxText = dataConsentCheckboxTxt
            }

            navigationController = UINavigationController(rootViewController: termsViewController)
            if let nav = navigationController{
                nav.modalPresentationStyle = .overFullScreen

                if #available(iOS 13.0, *) {
                    nav.modalPresentationStyle = .fullScreen
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
                    APApplicasterController.sharedInstance()?.rootViewController.topmostModal()?.present(nav, animated: true, completion: nil)
                }
            }
        }
    }

    public func executeAfterAppRootPresentation(displayViewController: UIViewController?, completion: (() -> Void)?) {
        if let alwaysShowScreen = configurationJSON?["always_show_screen_at_launch"] as? String {
            if (alwaysShowScreen == "1") {
                self.showTermsScreen()
            }
        } else if let showScreen = configurationJSON?["show_screen_at_launch"] as? String {
            if (showScreen == "1" && !(SMaxTermsAndConditionPreferencesManager.sharedInstance.boolForKey(ZappSMaxTermsAndCondition.self.termsScreenKey) ?? false)) {
                self.showTermsScreen()
            }
        }
    }
}
