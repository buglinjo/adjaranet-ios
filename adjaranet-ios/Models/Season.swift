//
//  Season.swift
//  AdjaraNet
//
//  Created by Irakli Tchitadze on 2/13/18.
//  Copyright © 2018 Irakli Tchitadze. All rights reserved.
//

import UIKit
import SwiftyJSON
import HTMLEntities

class Season: NSObject {
    var number: Int?
    var numberTrailed: String?
    var numberOfEpisodes: Int?
    var episodes: [Episode]?
    
    func fillEpisodes(episodes: JSON) {
        var episodesObj = [Episode]()
        
        for (_, episode) in episodes {
            let episodeObj = Episode()
            
            episodeObj.number = episode["number"].int
            episodeObj.numberTrailed = episode["number_trailed"].string
            episodeObj.title = episode["title"].string?.htmlUnescape()
            episodeObj.streamTemplate = episode["stream_template"].string
            episodeObj.subtitleTemplate = episode["subtitle_template"].string
            
            episodeObj.fillLanguages(languages: episode["languages"])
            episodeObj.fillQualities(qualities: episode["qualities"])
            episodeObj.fillSubtitles(subtitles: episode["subtitles"])
            
            episodesObj.append(episodeObj)
        }
        
        self.episodes = episodesObj
    }
}
