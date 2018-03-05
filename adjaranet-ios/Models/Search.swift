//
//  Search.swift
//  AdjaraNet
//
//  Created by Irakli Tchitadze on 12/1/17.
//  Copyright © 2017 Irakli Tchitadze. All rights reserved.
//

import UIKit
import SwiftyJSON

class Search {
    
    var searchText: String
    var videos: [Video]?
    
    init (searchText: String) {
        self.searchText = searchText
    }
}
