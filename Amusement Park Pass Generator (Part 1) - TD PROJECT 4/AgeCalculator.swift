//
//  AgeCalculator.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 7/16/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation



class AgeCalculator {
    let formatter = DateFormatter()    
    
    func calculateAgeFrom(birthDate dateString: String) -> Int {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let dateFromString = dateFormatter.date(from: dateString) else {
           fatalError()
        }
        
        return Calendar.current.dateComponents([.year], from: dateFromString, to: Date()).year!
    }
    
}
