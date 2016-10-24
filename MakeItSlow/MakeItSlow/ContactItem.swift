//
//  ContactItem.swift
//  MakeItSlow
//
//  Created by Tyreal Gray on 10/24/16.
//  Copyright © 2016 Tyreal Gray. All rights reserved.
//

import UIKit

struct ContactItem {
    var firstName: String?
    var lastName: String?
    
    init(firstName: String?, lastName: String?) {
        self.firstName = firstName
        self.lastName = lastName
    }
}