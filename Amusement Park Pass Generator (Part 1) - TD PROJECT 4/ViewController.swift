//
//  ViewController.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 6/30/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import UIKit

enum Fields {
    case dateOfBirth
    case SSN
    case projectNumber
    case firstName
    case lastName
    case company
    case streetAddress
    case city
    case state
    case zipCode
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
    func removeAllArrangedSubviews() {
        for view in self.arrangedSubviews {
            self.removeArrangedSubview(view)
        }
    }
}

extension UIFont {
    func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }
    
    func regularPrimary() -> UIFont {
        return UIFont.systemFont(ofSize: 24)
    }
    
    func regularSecondary() -> UIFont {
        return UIFont.systemFont(ofSize: 20)
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    
    
    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}


class ViewController: UIViewController {
//    let child = Guest(firstName: "Andrew", lastName: "Graves", age: 8, type: .freeChild)
    let swipe = Swipe()
    let create = Create()
    
    // Top level buttons
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var employeeButton: UIButton!
    @IBOutlet weak var managerButton: UIButton!
    @IBOutlet weak var vendorButton: UIButton!
    
    // Topish stackview + buttons
    @IBOutlet weak var bottomStackView: UIStackView!
    
    let button1 = UIButton(type: .system)
    let button2 = UIButton(type: .system)
    let button3 = UIButton(type: .system)
    let button4 = UIButton(type: .system)
    let button5 = UIButton(type: .system)
    
    
    // Fields
    @IBOutlet weak var dateOfBirthField: UITextField!
    @IBOutlet weak var SSNField: UITextField!
    @IBOutlet weak var projectNumberField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var streetAddressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    
    // Bottom Buttons
    @IBOutlet weak var generatePassButton: UIButton!
    @IBOutlet weak var populateDataButton: UIButton!
    
    var currentPrimaryButton = UIButton()
    var currentSecondaryButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bottomStackView.alignment = .center
        setupSecondaryButtonAttributes(for: [button1, button2, button3, button4, button5])
        bottomStackView.addArrangedSubviews([button1, button2, button3, button4, button5])
        disableFields()


        // Do any additional setup after loading the view.
        var employee: Employee?
        let employeeFailure: Employee?
        var guest: Guest?
        let guestFailure: Guest?
        var manager: Manager?
        
        guestPressed("me")

        
        // A normal guest creation instance
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
        
        // Fails because a guest is created to have a child pass but it too old
        do {
            guestFailure = try create.guest(firstName: "Andrew", lastName: "Graves", age: 8, isVIP: false)
        } catch invalidInformationError.missingCredential(let missingInformation) {
            print("Oops, looks like you forgot to input a \(missingInformation)")
            // Pop up an alert dialog
            
        } catch invalidInformationError.invalidAge {
            print("You are too old to obtain a child pass!")
            // Pop up an alert dialog
            
        } catch {
            fatalError()
        }
        
        
        // Normal employee pass
        do {
            employee = try create.employee(firstName: "Andrew", lastName: "Graves", streetAddress: "123 fake drive", city: "Fake Valley", state: "California", zipCode: 111111, type: .maintenance, projectNumber: nil)
        } catch invalidInformationError.missingCredential(let missingInformation) {
            print("Oops, looks like you forgot to input a \(missingInformation)")
            // Pop up an alert dialog
        } catch {
            fatalError()
        }
        
        
        // Fails because a street address is missing
        do {
            employeeFailure = try create.employee(firstName: "Andrew", lastName: "Graves", streetAddress: "", city: "Fake Valley", state: "California", zipCode: 111111, type: .maintenance, projectNumber: nil)
        } catch invalidInformationError.missingCredential(let missingInformation) {
            print("Oops, looks like you forgot to input a \(missingInformation)")
            // Pop up an alert dialog
        } catch {
            fatalError()
        }
        
        
        // Regular manager creation
        do {
            manager = try create.manager(firstName: "Andrew", lastName: "Graves", streetAddress: "123 fake drive", city: "Fake Valley", state: "California", zipCode: 111111)
        } catch invalidInformationError.missingCredential(let missingInformation) {
            print("Oops, looks like you forgot to input a \(missingInformation)")
            // Pop up an alert dialog
        } catch {
            fatalError()
        }
        

        // Call all the swipe methods here
        if let guest = guest {
            guest.swipe()
        }
        
        if let employee = employee {
            employee.swipe()
        }
        
        if let manager = manager {
            manager.swipe()
        }
        
    }
    
    func resetPrimaryButton(_ button: UIButton) {
        button.titleLabel?.font = button.titleLabel?.font.regularPrimary()
        button.setTitleColor(UIColor(red: 0.812, green: 0.761, blue: 0.875, alpha: 1.00), for: .normal)
    }
    
    func resetSecondaryButton(_ button: UIButton) {
        button.titleLabel?.font = button.titleLabel?.font.regularSecondary()
        button.setTitleColor(UIColor(red: 0.522, green: 0.494, blue: 0.561, alpha: 1.00), for: .normal)
    }
    
    func setupSecondaryButtonAttributes(for buttons: [UIButton]) {
        for button in buttons {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            button.setTitleColor(UIColor(red: 0.522, green: 0.494, blue: 0.561, alpha: 1.00), for: .normal)
            button.addTarget(self, action: #selector(secondaryButtonClicked), for: .touchUpInside)

        }
    }
    
    func enableFields(for fields: [Fields]) {
        disableFields()
        for field in fields {
            switch field {
            case .dateOfBirth: dateOfBirthField.isEnabled = true
            case .SSN: SSNField.isEnabled = true
            case .projectNumber: projectNumberField.isEnabled = true
            case .firstName: firstNameField.isEnabled = true
            case .lastName: lastNameField.isEnabled = true
            case .streetAddress: streetAddressField.isEnabled = true
            case .company: companyField.isEnabled = true
            case .city: cityField.isEnabled = true
            case .state: stateField.isEnabled = true
            case .zipCode: zipCodeField.isEnabled = true
            }
        }
    }
    
    func disableFields() {
        dateOfBirthField.isEnabled = false
        SSNField.isEnabled = false
        projectNumberField.isEnabled = false
        firstNameField.isEnabled = false
        lastNameField.isEnabled = false
        streetAddressField.isEnabled = false
        companyField.isEnabled = false
        cityField.isEnabled = false
        stateField.isEnabled = false
        zipCodeField.isEnabled = false
    }
    
    @objc func secondaryButtonClicked(_ sender: UIButton?) {
        guard let sender = sender else {
            fatalError()
            // do nothing
        }
        sender.titleLabel?.font = sender.titleLabel?.font.bold()
        sender.setTitleColor(.white, for: .normal)
        
        resetSecondaryButton(currentSecondaryButton)
        currentSecondaryButton = sender
        
        switch sender {
        case button1:
            if currentPrimaryButton == guestButton {
                //this is for child
                print("child")
                enableFields(for: [.dateOfBirth, .firstName, .lastName])
            }
        case button2:
            if currentPrimaryButton == guestButton {
                //this is for adult
                print("adult")
                enableFields(for: [.firstName, .lastName])
            }
        case button3:
            if currentPrimaryButton == guestButton {
                //this is for senior
                print("senior")
                enableFields(for: [.firstName, .lastName, .dateOfBirth])
            }
        case button4:
            if currentPrimaryButton == guestButton {
                //this is for VIP
                print("VIP")
                enableFields(for: [.firstName, .lastName])
            } else if currentPrimaryButton == employeeButton {
                // this is for contract workers
                print("contract")
                enableFields(for: [.firstName, .lastName, .streetAddress, .city, .state, .zipCode])
            }
        case button5:
            if currentPrimaryButton == guestButton {
                //this is for season pass
                print("seasonPass")
                enableFields(for: [.firstName, .lastName, .streetAddress, .city, .state, .zipCode])
            } else if currentPrimaryButton == employeeButton {
                // this is an error and should return an error
                print("error")
            }
        default: print("error")
        }
    }
    
    
    @IBAction func guestPressed(_ sender: Any) {
        resetPrimaryButton(currentPrimaryButton)
        
        guestButton.titleLabel?.font = guestButton.titleLabel?.font.bold()
        guestButton.setTitleColor(.white, for: .normal)
        
        if !bottomStackView.arrangedSubviews.contains(button5) {
            bottomStackView.addArrangedSubview(button5)
            button5.isHidden = false

        }
        
        for button in [button1, button2, button3, button4] {
            button.isHidden = false
        }
        
        button1.setTitle("Child", for: .normal)
        button2.setTitle("Adult", for: .normal)
        button3.setTitle("Senior", for: .normal)
        button4.setTitle("VIP", for: .normal)
        button5.setTitle("Season Pass", for: .normal)

        currentPrimaryButton = guestButton
    }
    
    @IBAction func employeePressed(_ sender: Any) {
        resetPrimaryButton(currentPrimaryButton)
        employeeButton.titleLabel?.font = employeeButton.titleLabel?.font.bold()
        employeeButton.setTitleColor(.white, for: .normal)
        
        if bottomStackView.arrangedSubviews.contains(button5) {
            bottomStackView.removeArrangedSubview(button5)
            button5.isHidden = true
        }
        
        for button in [button1, button2, button3, button4] {
            button.isHidden = false
        }

        button1.setTitle("Food Services", for: .normal)
        button2.setTitle("Ride Services", for: .normal)
        button3.setTitle("Maintenance", for: .normal)
        button4.setTitle("Contract", for: .normal)
        
        enableFields(for: [.firstName, .lastName, .city, .state, .streetAddress, .zipCode])
        
        currentPrimaryButton = employeeButton
    }
    
    @IBAction func managerPressed(_ sender: Any) {
        resetPrimaryButton(currentPrimaryButton)
        managerButton.titleLabel?.font = managerButton.titleLabel?.font.bold()
        managerButton.setTitleColor(.white, for: .normal)
        
        for button in [button1, button2, button3, button4, button5] {
            button.isHidden = true
        }
        
        enableFields(for: [.firstName, .lastName, .city, .state, .streetAddress, .zipCode])
        
        currentPrimaryButton = managerButton
    }
    
    @IBAction func vendorPressed(_ sender: Any) {
        resetPrimaryButton(currentPrimaryButton)
        vendorButton.titleLabel?.font = employeeButton.titleLabel?.font.bold()
        vendorButton.setTitleColor(.white, for: .normal)
        
        for button in [button1, button2, button3, button4, button5] {
            button.isHidden = true
        }
        
        enableFields(for: [.firstName, .lastName, .dateOfBirth, .company])
        
        currentPrimaryButton = vendorButton
    }
    
    @IBAction func generatePass(_ sender: Any) {
        // pass through all the relevent data depending on which top and bottomty button is selected
        
        switch currentSecondaryButton {
        case button1:
            if currentPrimaryButton == guestButton {
                //this is for child
                print("child")
            } else if currentPrimaryButton == employeeButton {
                // this is for food services
                print("food services")
            }
        case button2:
            if currentPrimaryButton == guestButton {
                //this is for adult
                print("adult")
            } else if currentPrimaryButton == employeeButton {
                // this is for ride services
                print("ride services")
            }
        case button3:
            if currentPrimaryButton == guestButton {
                //this is for senior
                print("senior")
            } else if currentPrimaryButton == employeeButton {
                // this is for maintenance
                print("maintenance")
            }
        case button4:
            if currentPrimaryButton == guestButton {
                //this is for VIP
                print("VIP")
            } else if currentPrimaryButton == employeeButton {
                // this is for contract workers
                print("contract")
            }
        case button5:
            if currentPrimaryButton == guestButton {
                //this is for season pass
                print("seasonPass")
            } else if currentPrimaryButton == employeeButton {
                // this is an error and should return an error
                print("error")
            }
            
        default: //TODO: Throw some error
            fatalError()
        }
    }
}

