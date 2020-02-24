//
//  SaveController.swift
//  MySwiftTemplate
//
//  Created by apple on 6/12/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation

class SaveController {
    static let sharedInstance = SaveController()
    private init(){}
    private let userDefault = UserDefaults.standard
}
