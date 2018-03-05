//
//  Section.swift
//  AdjaraNet
//
//  Created by Irakli Tchitadze on 12/1/17.
//  Copyright © 2017 Irakli Tchitadze. All rights reserved.
//

import UIKit

class Section: NSObject {
    var name: String
    var videos: [Video]
    var title: String?
    
    init (name: String, title: String?, videos: [Video]) {
        self.name = name
        self.title = title
        self.videos = videos
    }
}
