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
    var type: GuestType
    
    
    // General init
    init(firstName: String?, lastName: String?) throws {
        guard let firstName = firstName else {
            throw invalidInformationError.missingCredential(missing: "first name")
        }
        self.firstName = firstName

        guard let lastName = lastName else {
            throw invalidInformationError.missingCredential(missing: "last name")
        }
        self.lastName = lastName
        
        self.type = .classic
    }
    
    init(firstName: String?, lastName: String?, isVIP: Bool) throws {
        guard let firstName = firstName else {
            throw invalidInformationError.missingCredential(missing: "first name")
        }
        self.firstName = firstName
        
        guard let lastName = lastName else {
            throw invalidInformationError.missingCredential(missing: "last name")
        }
        self.lastName = lastName
        
        if isVIP {
            self.type = .vip
        } else {
            self.type = .classic
        }
    }
    
    // Child init method
    init(firstName: String?, lastName: String?, age: Int?) throws {
        guard let firstName = firstName else {
            throw invalidInformationError.missingCredential(missing: "first name")
        }
        self.firstName = firstName
        
        guard let lastName = lastName else {
            throw invalidInformationError.missingCredential(missing: "last name")
        }
        self.lastName = lastName
        
        if let age = age, age <= 5 {
            self.type = .freeChild
            self.age = age
        } else {
            throw invalidInformationError.invalidAge
//            self.type = .classic
        }
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
        case .vip:
            return RideSwipe(canSkip: true)
        }
    }
    
    func discountSwipe() -> DiscountSwipe {
        switch type {
        case .classic, .freeChild:
            return DiscountSwipe(foodDiscount: 0, merchDiscount: 0)
        case .vip:
            return DiscountSwipe(foodDiscount: 10, merchDiscount: 20)
        }
    }
    // if the guest is a child, they must have a DOB
    
    // if the guest if a VIP, they can skip all rides, and have a 10% discount on food and a 20% discount on merch
}

enum GuestType {
    case classic
    case vip
    case freeChild
}
