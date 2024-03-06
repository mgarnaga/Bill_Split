//
//  Person.swift
//  BillSplit
//
//  Created by iMac on 05/06/2023.
//  Copyright © 2023 Garnaga. All rights reserved.
//

import Foundation

struct Person {
    var name: String
    var share: Double = 0.00
    
    mutating func increment(by amount: Double) {
        share += amount
    }
    
    mutating func decrement(by amount: Double) {
        share -= amount
    }
}
