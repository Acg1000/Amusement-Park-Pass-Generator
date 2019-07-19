//
//  AgeCalculator.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 7/16/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation



class DateCalculator {
    let formatter = DateFormatter()    
    
    // given a formatted string that represents a date, it calculates your age
    func calculateAgeFrom(birthDate dateString: String) -> Int {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let dateFromString = dateFormatter.date(from: dateString) else {
           fatalError()
        }
        
        return Calendar.current.dateComponents([.year], from: dateFromString, to: Date()).year!
    }
    
    // returns the current date
    func currentDate() -> String {
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let stringFromDate = dateFormatter.string(from: currentDate)
        return stringFromDate
    }
    
}
