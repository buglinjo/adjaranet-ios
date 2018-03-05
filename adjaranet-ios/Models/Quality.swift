//
//  Quality.swift
//  AdjaraNet
//
//  Created by Irakli Tchitadze on 2/12/18.
//  Copyright © 2018 Irakli Tchitadze. All rights reserved.
//

import UIKit

class Quality: NSObject {
    let code: String
    let name: String
    let shortName: String
    
    init (code: String, name: String, shortName: String) {
        self.code = code
        self.name = name
        self.shortName = shortName
    }
}
