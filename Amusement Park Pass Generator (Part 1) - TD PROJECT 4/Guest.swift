//
//  Guest.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 6/30/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class Guest: Person {    
    var firstName: String?
    var lastName: String?
    var age: Int?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipCode: Int?
    var type: GuestType
    var personType: PersonType? {
        return PersonType(rawValue: type.rawValue)
    }
    
    
    // Init for Classic and VIPs
    init(firstName: String?, lastName: String?, isVIP: Bool) {
        
        self.firstName = firstName
        self.lastName = lastName
        
        if isVIP {
            self.type = .vip
        } else {
            self.type = .classic
        }
    }
    
    // Child and senior init method
    init(firstName: String?, lastName: String?, age: Int?) throws {
        
        self.firstName = firstName
        
        self.lastName = lastName
        
        guard let age = age else {
            throw invalidInformationError.missingCredential(missing: "age")
        }
        
        if age <= 5 {
            self.type = .freeChild
            self.age = age
        } else if age >= 60 {
            self.type = .senior
            self.age = age
        } else {
            throw invalidInformationError.invalidAge
        }
    }
    
    // Season Pass Guest
    init(firstName: String?, lastName: String?, streetAddress: String?, city: String?, state: String?, zipCode: String?) throws {
        
        guard let firstName = firstName, firstName != "" else {
            throw invalidInformationError.missingCredential(missing: "first name")
        }
        
        guard let lastName = lastName, lastName != "" else {
            throw invalidInformationError.missingCredential(missing: "last name")
        }
        
        guard let streetAddress = streetAddress, streetAddress != "" else {
            throw invalidInformationError.missingCredential(missing: "street address")
        }
        
        guard let city = city, city != "" else {
            throw invalidInformationError.missingCredential(missing: "city")
        }
        
        guard let state = state, state != "" else {
            throw invalidInformationError.missingCredential(missing: "state")
        }
        
        guard let zipCode = zipCode, zipCode != "" else {
            throw invalidInformationError.missingCredential(missing: "zip code")
        }
        
        guard let modifiedZipCode = Int(zipCode) else {
            throw invalidInformationError.invalidZipCode
        }
        
        
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = modifiedZipCode
        self.type = .seasonPass
    }
    
    
    var areas: [Areas] {
        return [.amusementAreas]
    }
    
    var foodDiscount: Int? {
        switch type {
        case .vip: return 10
        default: return nil
        }
    }
    
    var merchDiscount: Int? {
        switch type {
        case .vip: return 20
        default: return nil
        }
    }
    
    func areaSwipe() -> AreaSwipe {
        return AreaSwipe(areas: [.amusementAreas])
    }
    
    func rideSwipe() -> RideSwipe {
        switch type {
        case .classic, .freeChild:
            return RideSwipe(canSkip: false)
        case .vip, .seasonPass, .senior:
            return RideSwipe(canSkip: true)
        }
    }
    
    func discountSwipe() -> DiscountSwipe {
        switch type {
        case .classic, .freeChild:
            return DiscountSwipe(foodDiscount: 0, merchDiscount: 0)
        case .vip, .seasonPass:
            return DiscountSwipe(foodDiscount: 10, merchDiscount: 20)
        case .senior:
            return DiscountSwipe(foodDiscount: 10, merchDiscount: 10)
        }
    }
}

enum GuestType: String {
    case classic
    case vip
    case freeChild
    case seasonPass
    case senior
}
