//
//  ShadowView.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/10/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        super.awakeFromNib()
    }
}
