//
//  PassController.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 7/18/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import UIKit

class PassController: UIViewController {
    
    var person: Person?
    
    // Labels
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var attributeLabel1: UILabel!
    @IBOutlet weak var attributeLabel2: UILabel!
    @IBOutlet weak var attributeLabel3: UILabel!
    @IBOutlet weak var testResultsLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var areaAccessButton: UIButton!
    @IBOutlet weak var rideAccessButton: UIButton!
    @IBOutlet weak var discountAccessButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let person = person, let firstName = person.firstName, let lastName = person.lastName else {
            return
        }
        personNameLabel.text = "\(firstName)  \(lastName)"

        
        guard let personType = person.personType else {
            fatalError("no person type")
        }
        
        
        passTypeLabel.text = "\(personType) Pass".uppercased()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(person: Person) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
    }
    
    func resetTestResultsLabel() {
        testResultsLabel.text = ""
        testResultsLabel.backgroundColor = UIColor(red: 0.792, green: 0.776, blue: 0.808, alpha: 1.00)

    }
    
    
    @IBAction func areaAccessButton(_ sender: Any) {
        resetTestResultsLabel()
        
        let areaSwipe = person?.areaSwipe()
        guard let areas = areaSwipe?.areas else {
            // an actual error please
            fatalError()
        }
        
        for area in areas {
            testResultsLabel.text?.append(contentsOf: area.rawValue.uppercased())
            testResultsLabel.text?.append("\n")
        }
    }
    
    @IBAction func rideAccessButton(_ sender: Any) {
        resetTestResultsLabel()
        
        let rideSwipe = person?.rideSwipe()
        if let canSkip = rideSwipe?.canSkip, canSkip {
            testResultsLabel.backgroundColor  = .green
            testResultsLabel.text = "CAN SKIP"
        }
        
        testResultsLabel.backgroundColor  = .red
        testResultsLabel.text = "CAN NOT SKIP"
        
    }
    @IBAction func discountAccess(_ sender: Any) {
        resetTestResultsLabel()
        
        let discountSwipe = person?.discountSwipe()
        if let foodDiscount: Int = discountSwipe?.foodDiscount {
            testResultsLabel.text?.append("Food Discount: $\(foodDiscount) \n")

        }
        if let merchDiscount: Int = discountSwipe?.merchDiscount {
            testResultsLabel.text?.append("Merch Discount: $\(merchDiscount) \n")

        }
    }
}
