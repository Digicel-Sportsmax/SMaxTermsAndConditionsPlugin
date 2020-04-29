//
//  SMaxTermsAndConditionPreferencesManager.swift
//
//  Created by Mohieddine Zarif on 24/04/2020.
//

import Foundation


class SMaxTermsAndConditionPreferencesManager {
    static let sharedInstance = SMaxTermsAndConditionPreferencesManager()

    fileprivate let defaults = UserDefaults()

    // MARK: writing values methods
    func setBool(_ value: Bool, forKey defaultName: String) {
        defaults.set(value, forKey: defaultName)
        defaults.synchronize()
    }

    func boolForKey(_ defaultName: String ) -> Bool? {
        return defaults.bool(forKey: defaultName)
    }

}
