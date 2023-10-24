//
//  Employee.swift
//  JoinUS
//
//  Created by Bhavesh Patel on 22/10/23.
//

import Foundation

//Employee uniform details model
struct Employees: Identifiable {
    
    let id = UUID().uuidString
    let name: String
    let phone: String
    let gender: String
    let size: String
    
}
