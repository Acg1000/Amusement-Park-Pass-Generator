//
//  Person.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 7/1/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

protocol Person {
    var firstName: String? { get set }
    var lastName: String? { get set }
    var personType: PersonType? { get }
    
    func areaSwipe() -> AreaSwipe
    func discountSwipe() -> DiscountSwipe
    func rideSwipe() -> RideSwipe
}

enum PersonType: String {
    // Guest Types
    case classic
    case vip
    case freeChild
    case seasonPass
    case senior
    
    // Employee Types
    case food
    case ride
    case maintenance
    case contract
    
    case manager
    case vendor
}
