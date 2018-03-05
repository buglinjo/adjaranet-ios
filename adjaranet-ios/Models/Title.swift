//
//  Title.swift
//  AdjaraNet
//
//  Created by Irakli Tchitadze on 2/12/18.
//  Copyright © 2018 Irakli Tchitadze. All rights reserved.
//

import UIKit

class Title: NSObject {
    let text: String
    let language: Language
    
    init (text: String, language: Language) {
        self.text = text
        self.language = language
    }
}
