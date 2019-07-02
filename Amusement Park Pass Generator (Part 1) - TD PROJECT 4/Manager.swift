//
//  Manager.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 6/30/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class Manager: Person {
    var firstName: String
    var lastName: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: Int
    
    init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: Int ) throws {
        
        self.zipCode = zipCode
        
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
    }
    
    // approperate types need to access their designated areas
    var areas: [Areas] {
        return [.amusementAreas, .kitchenAreas, .maintenanceAreas, .officeAreas, .rideControlAreas]
    }
    
    // every employee needs to get the same discount so probibly a static function
    static var foodDiscount: Int = 25
    static var merchDiscount: Int = 25
    
    
    
    func areaSwipe() -> AreaSwipe {
        return AreaSwipe(areas: [.amusementAreas, .kitchenAreas, .maintenanceAreas, .officeAreas, .rideControlAreas])
    }
    
    func rideSwipe() -> RideSwipe {
        return RideSwipe(canSkip: false)
    }
    
    func discountSwipe() -> DiscountSwipe {
        return DiscountSwipe(foodDiscount: 25, merchDiscount: 25)
    }
    
}
