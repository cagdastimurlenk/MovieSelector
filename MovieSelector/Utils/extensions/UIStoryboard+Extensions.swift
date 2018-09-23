//
//  UIStoryboard+Extensions.swift
//  petsapp
//
//  Created by Cagdas on 26/08/2017.
//  Copyright © 2017 Tronasoft. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard{

    convenience init(name:String) {
        self.init(name: name, bundle: nil)
    }
}
