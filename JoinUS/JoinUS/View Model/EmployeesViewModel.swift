//
//  File.swift
//  JoinUS
//
//  Created by Bhavesh Patel on 22/10/23.
//

import Foundation
class EmployeesViewModel : NSObject {
    
    private var apiService : APIService!
    var empModel : Employees!
    
    override init() {
        super.init()
        self.apiService =  APIService()
    }
    
    func setEmpModel(model: Employees){
        self.empModel = model
        //call api
        callFuncToSaveEmpData()
    }
    
    func callFuncToSaveEmpData() {
        self.apiService.apiToSaveEmployeeData { (response) in
            //handle response
        }
    }
}
