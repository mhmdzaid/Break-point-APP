//
//  insetTextFieldVC.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/10/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class insetTextFieldVC: UITextField {

    override func awakeFromNib() {
        let placeHolder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        self.attributedPlaceholder = placeHolder
        super.awakeFromNib()
    }
    
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override  func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
       return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
 
    
}
