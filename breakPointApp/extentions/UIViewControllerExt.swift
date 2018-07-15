//
//  UIViewControllerExt.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/15/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

extension UIViewController{
    func presentDetail(_ viewControllerToPresent :UIViewController){
        let transition = CATransition()
        transition.duration  = 2
        transition.type = kCATransition
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func dismissDetail(){
        let transition = CATransition()
        transition.type = kCATransition
        transition.subtype = kCATransitionFromLeft
        transition.duration = 2
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
    }
}
