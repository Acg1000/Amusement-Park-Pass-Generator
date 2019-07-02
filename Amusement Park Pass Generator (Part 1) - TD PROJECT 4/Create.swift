//
//  CreatePerson.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 7/1/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class Create {
    
    func guest(firstName: String?, lastName: String?, age: Int?, isVIP: Bool) -> Guest? {
        
        do {
            if age != nil {
                return try Guest(firstName: firstName, lastName: lastName, age: age)
            } else {
                return try Guest(firstName: firstName, lastName: lastName, isVIP: isVIP)
            }
                        
        } catch invalidInformationError.missingCredential(let missingCredentials) {
            print("Oops! It looks like you forgot to enter \(missingCredentials)")
            return nil
            
        } catch invalidInformationError.invalidAge {
            print("Please enter a valid age for the free child pass")
            return nil

        } catch {
            print("Unexpected error: \(error)")
            return nil
        }
        
    }
    
    func employee(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: Int, type: EmployeeType) -> Employee? {
        do {
            return try Employee(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, type: type)
            
        } catch invalidInformationError.missingCredential(let missingCredentials) {
            print("Oops! It looks like you forgot to enter a \(missingCredentials)")
            return nil
            
        } catch {
            print("Unexpected error: \(error)")
            return nil
        }
    }
    func manager(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: Int) -> Manager? {
        do {
           return try Manager(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
            
        } catch invalidInformationError.missingCredential(let missingCredentials) {
            print("Oops! It looks like you forgot to enter a \(missingCredentials)")
            return nil
            
        } catch {
            print("Unexpected error: \(error)")
            return nil
        }
    }
    
}
