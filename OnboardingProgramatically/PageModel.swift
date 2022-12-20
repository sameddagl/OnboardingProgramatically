//
//  PageModel.swift
//  OnboardingProgramatically
//
//  Created by Samed Dağlı on 20.12.2022.
//

import UIKit

struct PageModel {
    let imageName: String
    let title: String
    let description: String
    
    var image: UIImage? {
        return UIImage(named: imageName)
    }
}
