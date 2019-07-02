//
//  Swipe.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 6/30/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

struct DiscountSwipe {
    var foodDiscount: Int
    var merchDiscount: Int
}

struct AreaSwipe {
    var areas: [Areas]
}

struct RideSwipe {
    var canSkip: Bool
}

class Swipe {
    func area(user: Person, area: Areas) {
        let areaResults = user.areaSwipe()
        for areaItem in areaResults.areas {
            if areaItem == area {
                print("Access Granted")
            } else {
                print("Access Denied")
            }
        }
    }
    
    func ride(user: Person) {
        let rideResults = user.rideSwipe()
        if rideResults.canSkip {
            print("Skipping Access Allowed")
        } else {
            print("Skipping Access Denied")
        }
    }
    
    func discount(user: Person) {
        let discountResults = user.discountSwipe()
        if discountResults.foodDiscount > 0 {
            print("User can recieve the following discount(s)")
            print("Food Discount: \(discountResults.foodDiscount)%")
        }
        
        if discountResults.merchDiscount > 0{
            print("Merch Discount: \(discountResults.merchDiscount)%")
        }
        
        else {
            print("No Discounts Available")
        }
    }
}
