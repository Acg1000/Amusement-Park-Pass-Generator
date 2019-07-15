//
//  Employee.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 6/30/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class Employee: Person {
    
    var firstName: String
    var lastName: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: Int
    var type: EmployeeType
    var projectNumber: Int?
    
    init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: Int, type: EmployeeType, projectNumber: Int?) throws {
        
        self.zipCode = zipCode
        self.type = type
        
        if firstName == "" {
            throw invalidInformationError.missingCredential(missing: "first name")
        } else if lastName == "" {
            throw invalidInformationError.missingCredential(missing: "last name")
        } else if streetAddress == "" {
            throw invalidInformationError.missingCredential(missing: "street address")
        } else if city == "" {
            throw invalidInformationError.missingCredential(missing: "city")
        } else if state == "" {
            throw invalidInformationError.missingCredential(missing: "state")
        } else {
            self.firstName = firstName
            self.lastName = lastName
            self.streetAddress = streetAddress
            self.city = city
            self.state = state
        }
        
        if let projectNumber = projectNumber {
            if projectNumber == 1001 || projectNumber == 1002 || projectNumber == 1003 || projectNumber == 2001 || projectNumber == 2002 {
                self.projectNumber = projectNumber
            } else {
                throw invalidInformationError.invalidProjectNumber(projectNumber: projectNumber)
            }
        }
    }
    
    // approperate types need to access their designated areas
//    var areas: [Areas] {
//        switch type {
//        case .food, .contract: return [.amusementAreas, .kitchenAreas]
//        case .ride: return [.amusementAreas, .rideControlAreas]
//        case .maintenance: return [.amusementAreas, .kitchenAreas, .rideControlAreas, .maintenanceAreas]
//        }
//    }
    
    
    func areaSwipe() -> AreaSwipe {
        switch type {
        case .food:
            return AreaSwipe(areas: [.amusementAreas, .kitchenAreas])
        case .ride:
            return AreaSwipe(areas: [.amusementAreas, .rideControlAreas])
        case .maintenance:
            return AreaSwipe(areas: [.amusementAreas, .kitchenAreas, .rideControlAreas, .maintenanceAreas])
        case .contract:
            if projectNumber == 1001 {
                return AreaSwipe(areas: [.amusementAreas, .rideControlAreas])
                
            } else if projectNumber == 1002 {
                return AreaSwipe(areas:[.amusementAreas, .rideControlAreas, .maintenanceAreas])
                
            } else if projectNumber == 1003 {
                return AreaSwipe(areas: [.amusementAreas, .kitchenAreas, .rideControlAreas, .maintenanceAreas, .officeAreas])
                
            } else if projectNumber == 2001 {
                return AreaSwipe(areas: [.officeAreas])
                
            } else if projectNumber == 2002 {
                return AreaSwipe(areas: [.kitchenAreas, .maintenanceAreas])

            } else {
                return AreaSwipe(areas: [])
            }
        }
    }
    
    func rideSwipe() -> RideSwipe {
        return RideSwipe(canSkip: false)
    }
    
    func discountSwipe() -> DiscountSwipe {
        return DiscountSwipe(foodDiscount: 15, merchDiscount: 25)
    }
}

enum EmployeeType {
    case food
    case ride
    case maintenance
    case contract
}
