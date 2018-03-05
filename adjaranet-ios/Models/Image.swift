//
//  Image.swift
//  AdjaraNet
//
//  Created by Irakli Tchitadze on 2/12/18.
//  Copyright © 2018 Irakli Tchitadze. All rights reserved.
//

import UIKit

class Image: NSObject {
    let size: String
    let resolution: String
    let url: String
    
    init (size: String, resolution: String, url: String) {
        self.size = size
        self.resolution = resolution
        self.url = url
    }
}
