//
//  UserDefaults+Extension.swift
//  OnboardingProgramatically
//
//  Created by Samed Dağlı on 20.12.2022.
//

import Foundation

extension UserDefaults {
    var hasOnboarded: Bool {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "hasOnboarded")
        }
        
        get {
            if UserDefaults.standard.bool(forKey: "hasOnboarded") as Bool == true {
                return true
            }
            else {
                return false
            }
        }
    }
}
