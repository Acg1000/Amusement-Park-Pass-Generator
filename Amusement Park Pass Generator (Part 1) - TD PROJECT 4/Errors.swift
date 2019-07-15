//
//  Errors.swift
//  Amusement Park Pass Generator (Part 1) - TD PROJECT 4
//
//  Created by Andrew Graves on 7/1/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

enum invalidInformationError: Error {
    case missingCredential(missing: String)
    case invalidAge
    case invalidProjectNumber(projectNumber: Int)
}
