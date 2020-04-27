//
//  SMaxTermsAndConditionPreferencesManager.swift
//
//  Created by Mohieddine Zarif on 24/04/2020.
//

import Foundation


public class SMaxTermsAndConditionPreferencesManager {

    fileprivate let termsScreenShown = "SMaxTermsAndConditionPreferencesManager.termsHasBeenShown"

    static func termsScreenHasBeenShown() {
        UserDefaults.standard.set(true, forKey: termsScreenShown)
    }

    static func getStatusOfTermsScreen() -> Bool {
        return false
    }
}
