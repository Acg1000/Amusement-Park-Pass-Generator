//
//  Person.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 7/1/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

protocol Person {
    func areaSwipe() -> AreaSwipe
    func discountSwipe() -> DiscountSwipe
    func rideSwipe() -> RideSwipe
}
