//
//  Swipe.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 6/30/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

protocol IsSwipeable {
    
}

extension Person {
    func swipe() {
        print("\n Accessable Areas: ")
        for area in self.areaSwipe().areas {
            print(area)
        }
        print("\n Accessable Discounts: ")
        if self.discountSwipe().merchDiscount != 0 {
            print("Merch Discount: \(self.discountSwipe().merchDiscount)")
        }
        
        if self.discountSwipe().foodDiscount != 0 {
            print("Food Discount: \(self.discountSwipe().foodDiscount)")
            
        }

        if self.rideSwipe().canSkip {
            print("\n Can skip lines")
        } else {
            print("\n Can't skip lines")
        }
    }
}

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
                return
            }
        }
        print("Access Denied")
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
