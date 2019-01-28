//
//  textFieldsDelegates.swift
//  Memo 1.0 Project V2
//
//  Created by apple on 14/03/1440 AH.
//  Copyright © 1440 Student@Udacity. All rights reserved.
//
/////////////////
import UIKit
import Foundation
/////////////////

class textFieldsDelegates : NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Mark: // when want to write somthing
        var addFreshText = textField.text! as NSString
        addFreshText = addFreshText.replacingCharacters(in: range, with: string) as NSString
        
        return true
    }
    // ******************************************************* //
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Mark: // to check if the text field is empty
        if !textField.text!.isEmpty {
            
            textField.text = ""
        }
    }
    // ******************************************************* //
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}
