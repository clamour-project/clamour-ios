//
//  Result.swift
//  Clamour
//
//  Created by San Byn Nguyen on 23.04.2018.
//  Copyright © 2018 Udacity. All rights reserved.
//
import UIKit
import Foundation

class Result {
    var type: String = ""
    var suitableTypes: [String] = []
    var suitableColors: [UIColor] = []
    var suitableClothes: [String] = []
    
    init(type: String, suitable: [String], suitColors: [UIColor], suitClothes: [String]) {
        self.type = type
        self.suitableTypes = suitable
        self.suitableColors = suitColors
        self.suitableClothes = suitClothes
    }
}
