//
//  ViewController.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 6/30/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    let child = Guest(firstName: "Andrew", lastName: "Graves", age: 8, type: .freeChild)
    let swipe = Swipe()
    let create = Create()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let guest = create.guest(firstName: "Andrew", lastName: "Graves", age: nil, isVIP: true)
        let employee = create.employee(firstName: "Andrew", lastName: "Graves", streetAddress: "424 Freshmeadows Rd.", city: "Simi Valley", state: "California", zipCode: 93065, type: .maintenance)
        let manager = create.manager(firstName: "Andrew", lastName: "Graves", streetAddress: "123 fake drive", city: "Fake Valley", state: "California", zipCode: 11111)
        
        if let guest = create.guest(firstName: "Andrew", lastName: "Graves", age: nil, isVIP: true) {
            swipe.ride(user: guest)
            swipe.area(user: guest, area: .kitchenAreas)
            swipe.discount(user: guest)
        }
        
        
    }
}

