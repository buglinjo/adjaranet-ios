//
//  Language.swift
//  AdjaraNet
//
//  Created by Irakli Tchitadze on 2/12/18.
//  Copyright © 2018 Irakli Tchitadze. All rights reserved.
//

import UIKit

class Language: NSObject {
    let name: String
    let local: String
    let iso_639_1: String
    let iso_639_2b: String
    
    init (name: String, local: String, iso_639_1: String, iso_639_2b: String) {
        self.name = name
        self.local = local
        self.iso_639_1 = iso_639_1
        self.iso_639_2b = iso_639_2b
    }
}
