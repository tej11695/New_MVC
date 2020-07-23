//
//  @IBDesignable.swift
//  TLV
//
//  Created by eSparkBiz-1 on 29/04/19.
//  Copyright © 2019 eSparkBiz-1. All rights reserved.
//

import UIKit
@IBDesignable

class IBDesignable: UIButton
{
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 1.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}


