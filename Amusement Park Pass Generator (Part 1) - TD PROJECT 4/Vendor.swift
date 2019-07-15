//
//  Vendor.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 7/14/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class Vendor: Person {
   
    
    var firstName: String
    var lastName: String
    var vendorCompany: Vendors
    var dateOfBirth: String
    var dateOfVisit: String
    
    init(firstName: String, lastName: String, vendorCompany: Vendors, dateOfBirth: String, dateOfVisit: String) throws {
        
            self.firstName = firstName
            self.lastName = lastName
            self.vendorCompany = vendorCompany
            self.dateOfBirth = dateOfBirth
            self.dateOfVisit = dateOfVisit
        }
    
    
    func areaSwipe() -> AreaSwipe {
        switch vendorCompany {
        case .acme:
            return AreaSwipe(areas: [.kitchenAreas,])
        case .fedex:
            return AreaSwipe(areas: [.amusementAreas, .rideControlAreas, .kitchenAreas])
        case .nwElectrical:
            return AreaSwipe(areas: [.maintenanceAreas, .officeAreas])
        case .orkin:
            return AreaSwipe(areas: [.amusementAreas, .kitchenAreas, .maintenanceAreas, .officeAreas, .rideControlAreas])
        }
    }
    
    func rideSwipe() -> RideSwipe {
        return RideSwipe(canSkip: false)
    }
    
    func discountSwipe() -> DiscountSwipe {
        return DiscountSwipe(foodDiscount: 0, merchDiscount: 0)
    }
    
}

enum Vendors: String {
    case acme
    case orkin
    case fedex
    case nwElectrical
}
