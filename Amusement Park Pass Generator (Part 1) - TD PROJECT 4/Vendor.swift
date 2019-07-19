//
//  Vendor.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 7/14/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class Vendor: Person {
    var firstName: String?
    var lastName: String?
    var vendorCompany: Vendors
    var dateOfBirth: String
    var dateOfVisit: String
    let personType: PersonType? = PersonType.vendor
    
    init(firstName: String?, lastName: String?, vendorCompanyString: String?, dateOfBirth: String?, dateOfVisit: String?) throws {
        
        guard let firstName = firstName, firstName != "" else {
            throw invalidInformationError.missingCredential(missing: "first name")
        }
        
        guard let lastName = lastName, lastName != "" else {
            throw invalidInformationError.missingCredential(missing: "last name")
        }
        
        guard let vendorCompanyString = vendorCompanyString, vendorCompanyString != "" else {
            throw invalidInformationError.invalidVendorCompany(name: nil)
        }
        
        guard let dateOfBirth = dateOfBirth, dateOfBirth != "" else {
            throw invalidInformationError.invalidDateOfBirth
        }
        
        guard let dateOfVisit = dateOfVisit, dateOfVisit != ""  else {
            throw invalidInformationError.invalidDateOfVisit
        }
        
        guard let vendorCompany = Vendors(rawValue: vendorCompanyString) else {
            throw invalidInformationError.invalidVendorCompany(name: vendorCompanyString)
        }
        self.vendorCompany = vendorCompany
        
        
        self.firstName = firstName
        self.lastName = lastName
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
    case acme = "Acme"
    case orkin = "Orkin"
    case fedex = "Fedex"
    case nwElectrical = "NW Electrical"
}
