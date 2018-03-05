//
//  Episode.swift
//  AdjaraNet
//
//  Created by Irakli Tchitadze on 2/12/18.
//  Copyright © 2018 Irakli Tchitadze. All rights reserved.
//

import UIKit
import SwiftyJSON

class Episode: NSObject {
    var number: Int?
    var numberTrailed: String?
    var title: String?
    var streamTemplate: String?
    var subtitleTemplate: String?
    var languages: [Language]?
    var qualities: [Quality]?
    var subtitles: [Language]?

    func getStreamUrl(language: Language, quality: Quality) -> String? {
        var streamUrl: String = ""

        if let streamTemplate = self.streamTemplate {
            streamUrl = streamTemplate
                    .replacingOccurrences(of: "{lang}", with: language.name)
                    .replacingOccurrences(of: "{quality}", with: quality.code)
        }

        return streamUrl
    }
    
    func fillLanguages(languages: JSON) {
        var languagesObj = [Language]()
        
        for (_, language) in languages {
            languagesObj.append(Language(
                name: language["name"].string!,
                local: language["local"].string!,
                iso_639_1: language["iso_639_1"].string!,
                iso_639_2b: language["iso_639_2b"].string!
            ))
        }
        
        self.languages = languagesObj
    }
    
    func fillQualities(qualities: JSON) {
        var qualitiesObj = [Quality]()
        
        for (_, quality) in qualities {
            qualitiesObj.append(Quality(
                code: quality["code"].string!,
                name: quality["name"].string!,
                shortName: quality["short_name"].string!
            ))
        }
        
        self.qualities = qualitiesObj
    }
    
    func fillSubtitles(subtitles: JSON) {
        var subtitlesObj = [Language]()
        
        for (_, subtitle) in subtitles {
            subtitlesObj.append(Language(
                name: subtitle["name"].string!,
                local: subtitle["local"].string!,
                iso_639_1: subtitle["iso_639_1"].string!,
                iso_639_2b: subtitle["iso_639_2b"].string!
            ))
        }
        
        self.subtitles = subtitlesObj
    }
}
