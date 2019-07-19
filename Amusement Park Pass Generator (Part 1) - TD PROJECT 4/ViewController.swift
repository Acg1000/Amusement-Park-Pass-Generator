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
    let ageCalculator = AgeCalculator()
    
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
    @IBOutlet weak var dateOfVisitField: UITextField!
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let person = generatePass()
        
        guard let passController = segue.destination as? PassController else {
            return
        }
        
        passController.person = person
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomStackView.alignment = .center
        setupSecondaryButtonAttributes(for: [button1, button2, button3, button4, button5])
        bottomStackView.addArrangedSubviews([button1, button2, button3, button4, button5])
        disableFields()

        print(ageCalculator.calculateAgeFrom(birthDate: "08/07/2001"))

        // Do any additional setup after loading the view.
        var employee: Employee?
        let employeeFailure: Employee?
        var guest: Guest?
        let guestFailure: Guest?
        var manager: Manager?
        
        guestPressed("me")
        

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
            case .SSN: dateOfVisitField.isEnabled = true
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
        dateOfVisitField.isEnabled = false
        projectNumberField.isEnabled = false
        firstNameField.isEnabled = false
        lastNameField.isEnabled = false
        streetAddressField.isEnabled = false
        companyField.isEnabled = false
        cityField.isEnabled = false
        stateField.isEnabled = false
        zipCodeField.isEnabled = false
    }
    
    
    // MARK: Alert functions
    func showAlert(title: String, with message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
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

    //=========================================
    // MARK: TOP BUTTON PRESSES
    //=========================================
    
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
        vendorButton.titleLabel?.font = vendorButton.titleLabel?.font.bold()
        vendorButton.setTitleColor(.white, for: .normal)
        
        for button in [button1, button2, button3, button4, button5] {
            button.isHidden = true
        }
        
        enableFields(for: [.firstName, .lastName, .dateOfBirth, .company])
        
        currentPrimaryButton = vendorButton
    }
    
    //=========================================
    // MARK: BOTTOM BUTTON PRESSES
    //=========================================
    
    func generatePass() -> Person? {
        // pass through all the relevent data depending on which top and bottomty button is selected
        if currentPrimaryButton == managerButton {
            do {
                let person = try Manager(firstName: firstNameField.text, lastName: lastNameField.text, streetAddress: streetAddressField.text, city: cityField.text, state: stateField.text, zipCode: zipCodeField.text)
                
                return person
                
            } catch invalidInformationError.invalidZipCode {
                showAlert(title: "Invalid Zipcode", with: "Please enter a zip code that only consists of numbers")
            } catch invalidInformationError.missingCredential(let missingCreds) {
                showAlert(title: "Missing Credentials", with: "It looks like you forgot to input any information for your \(missingCreds)" )
            } catch let error {
                fatalError("\(error)")
            }
            
        } else if currentPrimaryButton == vendorButton {
            
            do {
                let person = try Vendor(firstName: firstNameField.text, lastName: lastNameField.text, vendorCompanyString: companyField.text, dateOfBirth: dateOfBirthField.text, dateOfVisit: dateOfVisitField.text)
                
                return person
                
            } catch invalidInformationError.invalidDateOfBirth {
                showAlert(title: "Invalid Date Of Birth", with: "Please enter a valid DOB")
            } catch invalidInformationError.invalidDateOfVisit {
                showAlert(title: "Invalid Date Of Visit", with: "Please enter a valid DOV")
            } catch invalidInformationError.invalidZipCode {
                showAlert(title: "Invalid Zipcode", with: "Please enter a zip code that only consists of numbers")
            } catch invalidInformationError.missingCredential(let missingCreds) {
                showAlert(title: "Missing Credentials", with: "It looks like you forgot to input any information for your \(missingCreds)" )
            } catch let error {
                fatalError("\(error)")
            }
            
        } else {
            switch currentSecondaryButton {
            case button1:
                if currentPrimaryButton == guestButton {
                    //this is for child
                    // If the following field is filled
                    do {
                        let person = try Guest(firstName: firstNameField.text, lastName: lastNameField.text, age: ageCalculator.calculateAgeFrom(birthDate: dateOfBirthField.text ?? ""))
                        
                        return person
                        
                    } catch invalidInformationError.invalidAge {
                        showAlert(title: "Invalid Age", with: "You are too old to obtain the free child pass...")
                    } catch let error {
                        fatalError("\(error)")
                    }
                    
                } else if currentPrimaryButton == employeeButton {
                    // this is for food services
                    
                    
                    do {
                        let person = try Employee(firstName: firstNameField.text, lastName: lastNameField.text, streetAddress: streetAddressField.text, city: cityField.text, state: stateField.text, zipCode: zipCodeField?.text, type: .food)
                        
                        return person
                        
                    } catch invalidInformationError.missingCredential(let missingCreds) {
                        showAlert(title: "Missing Credentials", with: "It looks like you forgot to input any information for your \(missingCreds)" )
                        
                    } catch invalidInformationError.invalidZipCode {
                        showAlert(title: "Invalid Zipcode", with: "Please enter a zip code that only consists of numbers")
                        
                    } catch let error {
                        fatalError("\(error)")
                    }
                }
                
            case button2:
                if currentPrimaryButton == guestButton {
                    //this is for adult
                    let person = Guest(firstName: firstNameField.text, lastName: lastNameField.text, isVIP: false)
                    
                    return person
                    
                    
                } else if currentPrimaryButton == employeeButton {
                    // this is for ride services
                    
                    do {
                        let person = try Employee(firstName: firstNameField.text, lastName: lastNameField.text, streetAddress: streetAddressField.text, city: cityField.text, state: stateField.text, zipCode: zipCodeField?.text, type: .ride)
                        
                        return person
                        
                    } catch invalidInformationError.missingCredential(let missingCreds) {
                        showAlert(title: "Missing Credentials", with: "It looks like you forgot to input any information for your \(missingCreds)" )
                        
                    } catch invalidInformationError.invalidZipCode {
                        showAlert(title: "Invalid Zipcode", with: "Please enter a zip code that only consists of numbers")
                        
                    } catch let error {
                        fatalError("\(error)")
                    }
                }
                
            case button3:
                if currentPrimaryButton == guestButton {
                    //this is for senior
                    do {
                        let person = try Guest(firstName: firstNameField.text, lastName: lastNameField.text, age: ageCalculator.calculateAgeFrom(birthDate: dateOfBirthField.text ?? ""))
                        
                        return person
                        
                    } catch invalidInformationError.invalidAge {
                        showAlert(title: "Invalid Age", with: "You are too old to obtain the free child pass...")
                    } catch let error {
                        fatalError("\(error)")
                    }
                    
                } else if currentPrimaryButton == employeeButton {
                    // this is for maintenance
                    
                    do {
                        let person = try Employee(firstName: firstNameField.text, lastName: lastNameField.text, streetAddress: streetAddressField.text, city: cityField.text, state: stateField.text, zipCode: zipCodeField?.text, type: .maintenance)
                        
                        return person
                        
                    } catch invalidInformationError.missingCredential(let missingCreds) {
                        showAlert(title: "Missing Credentials", with: "It looks like you forgot to input any information for your \(missingCreds)" )
                        
                    } catch invalidInformationError.invalidZipCode {
                        showAlert(title: "Invalid Zipcode", with: "Please enter a zip code that only consists of numbers")
                        
                    } catch let error {
                        fatalError("\(error)")
                    }
                }
                
            case button4:
                if currentPrimaryButton == guestButton {
                    //this is for VIP
                    
                    let person = Guest(firstName: firstNameField.text, lastName: lastNameField.text, isVIP: true)
                    
                    return person
                    
                    
                } else if currentPrimaryButton == employeeButton {
                    // this is for contract workers
                    
                    do {
                        let person = try Employee(firstName: firstNameField.text, lastName: lastNameField.text, streetAddress: streetAddressField.text, city: cityField.text, state: stateField.text, zipCode: zipCodeField.text, type: .contract, projectNumber: projectNumberField.text)
                        
                        return person
                    } catch invalidInformationError.projectNumberIsNotInt {
                        showAlert(title: "Invalid Project Number", with: "The project number provided is not a number...")
                    } catch invalidInformationError.invalidProjectNumber(let projectNumber) {
                        showAlert(title: "invalid Project Number", with: "\(projectNumber) is not a valid project number...")
                    } catch invalidInformationError.invalidZipCode {
                        showAlert(title: "Invalid Zipcode", with: "Please enter a zip code that only consists of numbers")
                    } catch invalidInformationError.missingCredential(let missingCreds) {
                        showAlert(title: "Missing Credentials", with: "It looks like you forgot to input any information for your \(missingCreds)" )
                    } catch let error {
                        fatalError("\(error)")
                    }
                }
                
            case button5:
                if currentPrimaryButton == guestButton {
                    //this is for season pass
                    
                    do {
                        let person = try Guest(firstName: firstNameField.text, lastName: lastNameField.text, streetAddress: streetAddressField.text, city: cityField.text, state: stateField.text, zipCode: zipCodeField.text)
                        
                        return person
                        
                    } catch invalidInformationError.invalidZipCode {
                        showAlert(title: "Invalid Zipcode", with: "Please enter a zip code that only consists of numbers")
                    } catch invalidInformationError.missingCredential(let missingCreds) {
                        showAlert(title: "Missing Credentials", with: "It looks like you forgot to input any information for your \(missingCreds)" )
                    } catch let error {
                        fatalError("\(error)")
                    }
                    
                } else if currentPrimaryButton == employeeButton {
                    // this is an error and should return an error
                    print("error")
                }
            default:
                showAlert(title: "Select a Type", with: "Please select a type on the top bar to continue")
            }
        }
        return nil
    }
}

