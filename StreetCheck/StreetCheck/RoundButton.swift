//
//  RoundButton.swift
//  StreetCheck
//
//  Created by Presley Reed III on 4/1/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var roundButton: Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height/2
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton{
            layer.cornerRadius = frame.height/2
        }
    }

}
