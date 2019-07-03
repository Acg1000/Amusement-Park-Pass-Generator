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
        var employee: Employee?
        var guest: Guest?

        do {
            guest = try create.guest(firstName: "Andrew", lastName: "Graves", age: nil, isVIP: true)
        } catch invalidInformationError.missingCredential(let missingInformation) {
            print("Oops, looks like you forgot to input a \(missingInformation)")
            // Pop up an alert dialog

        } catch invalidInformationError.invalidAge {
            print("You are too old to obtain a child pass!")
            // Pop up an alert dialog
            
        } catch {
            fatalError()
        }
        
        
        
        do {
            employee = try create.employee(firstName: "Andrew", lastName: "Graves", streetAddress: "123 fake drive", city: "Fake Valley", state: "California", zipCode: 111111, type: .maintenance)
        } catch invalidInformationError.missingCredential(let missingInformation) {
            print("Oops, looks like you forgot to input a \(missingInformation)")
            // Pop up an alert dialog
        } catch {
            fatalError()
        }
        

        
        if let guest = guest {
            guest.swipe()
        }
        
        if let employee = employee {
            employee.swipe()
        }
        
    }
}

