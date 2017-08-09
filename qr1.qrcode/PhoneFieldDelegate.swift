//
//  PhoneFieldDelegate.swift
//  qr1.qrcode
//
//  Created by Bahaeddin Sagar on 8/5/17.
//  Copyright © 2017 Almadar Aljadid. All rights reserved.
//

import Foundation
import UIKit
class PhoneFieldDelegate : NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let regEX = "^(?:|[0-9]{0,13})?$"
        let newstring = textField.text! + string
        if newstring.range(of: regEX, options:.regularExpression) != nil {
            return true
        } else {
            return false
        }
    }

    
    
}
