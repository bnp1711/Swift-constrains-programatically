//
//  FieldValidator.swift
//  JoinUSUITests
//
//  Created by Bhavesh Patel on 21/10/23.
//

import Foundation
import UIKit

class FieldValidator {
    
    //Name
    func validateNameField(input: String) -> Bool{
        // Regular expression to match alphabetic characters only and a length between 5 and 35 characters.
        let regex = "^[a-zA-Z]{5,35}$"
        
        // Create a predicate with the regex
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        // Use the predicate to test the input
        return predicate.evaluate(with: input)
    }
    
    func validateOnlyAlphabetscharacters(input: String) -> Bool{
        // Regular expression to match alphabetic characters only and a length between 5 and 35 characters.
        let regex = "[a-zA-Z]"
        
        // Create a predicate with the regex
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        // Use the predicate to test the input
        return predicate.evaluate(with: input)
    }
    
    func validateMinLength(input: String) -> Bool{
        return input.count < 5
    }
    
    func validateMaxLength(input: String) -> Bool{
        return input.count >= 35
    }
    
    //Phone
    func validatePhoneNumber(input: String) -> Bool{
        // Define the regular expression pattern
        let phoneRegex = "^\\+[0-9]{11}$"
        
        // Create a regular expression object
        if let regex = try? NSRegularExpression(pattern: phoneRegex, options: []) {
            // Use the regular expression to evaluate the phone number
            let range = NSRange(location: 0, length: input.utf16.count)
            if let _ = regex.firstMatch(in: input, options: [], range: range) {
                // The phone number is valid
                return true
            }
        }
        
        // The phone number is not valid
        return false
    }
}
