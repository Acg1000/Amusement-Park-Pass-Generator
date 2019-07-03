//
//  CreatePerson.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 7/1/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class Create {
    
    func guest(firstName: String?, lastName: String?, age: Int?, isVIP: Bool) throws -> Guest? {
        
        if age != nil {
            return try Guest(firstName: firstName, lastName: lastName, age: age)
        } else {
            return try Guest(firstName: firstName, lastName: lastName, isVIP: isVIP)
        }

        
    }
    
    func employee(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: Int, type: EmployeeType) throws -> Employee? {
        
        return try Employee(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, type: type)

    }
    
    func manager(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: Int) throws -> Manager? {
        
        return try Manager(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
    }
}
