//
//  Currency.swift
//  currency
//
//  Created by Hameleonlab on 26.02.18.
//  Copyright © 2018 hameleonlab. All rights reserved.
//

import UIKit

class Currency: NSObject {
    
    var curName: String
    var curVolume: Int
    var curAmount: Double
    
    init(name: String, volume: Int, amount: Double){
        
        self.curName = name
        self.curVolume = volume
        self.curAmount = amount
    }

    
}
