//
//  Rating.swift
//  AdjaraNet
//
//  Created by Irakli Tchitadze on 2/12/18.
//  Copyright © 2018 Irakli Tchitadze. All rights reserved.
//

import UIKit

class Rating: NSObject {
    let website: String
    let url: String?
    let icon: String?
    let rating: Float
    
    init (website: String, url: String?, icon: String?, rating: Float) {
        self.website = website
        self.url = url
        self.icon = icon
        self.rating = rating
    }
}
