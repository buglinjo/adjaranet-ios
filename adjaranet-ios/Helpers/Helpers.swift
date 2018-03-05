//
//  Helpers.swift
//  AdjaraNet
//
//  Created by Irakli Tchitadze on 11/26/17.
//  Copyright © 2017 Irakli Tchitadze. All rights reserved.
//

import UIKit
import Alamofire

class Helpers {
    
    static func getOnlyURL(string: String) -> String {
        return self.matches(for: "https?://[^ ')]+", in: string)[0]
    }
    
    static func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}

extension String {
    func titleCase() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func titleCase() {
        self = self.titleCase()
    }

    func lowerCase() -> String {
        return lowercased()
    }
}
