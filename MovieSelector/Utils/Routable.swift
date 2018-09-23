//
//  Routable.swift
//  petsapp
//
//  Created by Cagdas on 26/08/2017.
//  Copyright © 2017 Tronasoft. All rights reserved.
//

import Foundation
import UIKit


protocol Routable {
    associatedtype StoryboardIdentifier:RawRepresentable
    func present<T: UIViewController>(storyboard:StoryboardIdentifier,
                 identifier:String?,
                 animate:Bool,
                 modalPresentationStyle:UIModalPresentationStyle?,
                 addInNavigationController:Bool,
                 configure:((T)->Void)?,
                 completion:((T) -> Void)?)
    
    func show<T: UIViewController>(storyboard:StoryboardIdentifier,
              identifier:String?,
              showMenuOnNavigationBar: Bool,
              configure:((T) -> Void)?)
}


extension Routable where Self:UIViewController{
    func present<T: UIViewController>(storyboard:StoryboardIdentifier,
                 identifier:String? = nil,
                 animate:Bool = true,
                 modalPresentationStyle:UIModalPresentationStyle? = nil,
                 addInNavigationController:Bool = false,
                 configure: ((T) -> Void)? = nil,
                 completion: ((T) -> Void)? = nil){
        
        let storyboard = UIStoryboard(name: storyboard.rawValue)
        
        guard let controller = (identifier != nil
            ? storyboard.instantiateViewController(withIdentifier: identifier!)
            : storyboard.instantiateInitialViewController()) as? T
            else{
                return assertionFailure("Invalid controller for storyboard \(storyboard).")
        }
        
        if let modalPresentationStyle = modalPresentationStyle{
            controller.modalPresentationStyle = modalPresentationStyle
        }
        
        configure?(controller)
        
        controller.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

        
        if addInNavigationController{
            let navigationController = UINavigationController(rootViewController: controller)
            present(navigationController, animated: animate) {
                completion?(controller)
            }
        }else{
            present(controller, animated: animate) {
                completion?(controller)
            }
        }
        
        
        
    }
    
    
    
    func show<T:UIViewController>(storyboard:StoryboardIdentifier,
              identifier:String? = nil,
              showMenuOnNavigationBar: Bool = true,
              configure:((T) -> Void)? = nil){
        let storyboard = UIStoryboard(name: storyboard.rawValue)
        
        guard let controller = (identifier != nil
            ? storyboard.instantiateViewController(withIdentifier: identifier!)
            : storyboard.instantiateInitialViewController()) as? T
            else{
                return assertionFailure("Invalid controller for storyboard \(storyboard).")
        }
        
        controller.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        configure?(controller)
        
        show(controller, sender: self)
        
    }
}
