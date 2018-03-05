//
//  Video.swift
//  AdjaraNet
//
//  Created by Irakli Tchitadze on 12/1/17.
//  Copyright © 2017 Irakli Tchitadze. All rights reserved.
//

import UIKit
import SwiftyJSON

class Video: NSObject {
    let id: String
    let titles: [Title]
    let images: [Image]
    var type: String?
    var streamTemplate: String?
    var subtitleTemplate: String?
    var languages: [Language]?
    var qualities: [Quality]?
    var subtitles: [Language]?
    var details: Details?
    var ratings: [Rating]?
    var celebrities: [Celebrity]?
    var seasons: [Season]?
    
    init (id: String, titles: [Title], images: [Image]) {
        self.id = id
        self.titles = titles
        self.images = images
    }
    
    func getStreamUrl(languageName: String, qualityCode: String) -> String? {
        var streamUrl: String = ""

        if let streamTemplate = self.streamTemplate {
            streamUrl = streamTemplate
                    .replacingOccurrences(of: "{lang}", with: languageName)
                    .replacingOccurrences(of: "{quality}", with: qualityCode)

            if self.type == "series" {
                streamUrl = streamUrl
                        .replacingOccurrences(of: "{season}", with: "01")
                        .replacingOccurrences(of: "{episode}", with: "01")
            }
        }

        return streamUrl
    }
    
    func getImageBySize(size: String) -> Image? {
        for image in self.images {
            if image.size == size {
                return image
            }
        }
        
        return nil
    }
    
    func getTitleByLocale(locale: String) -> Title? {
        for title in self.titles {
            if title.language.iso_639_2b == locale {
                return title
            }
        }
        
        return nil
    }
    
    func getRequestHeaders() -> [String: String] {
        return [
            "Host": "net.adjara.com",
            "Origin": "http://net.adjara.com",
            "Referer": "http://net.adjara.com/Movie/main?id=" + self.id,
        ]
    }
    
    func getQualityByName(name: String) -> Quality? {
        if let qualities = self.qualities {
            for quality in qualities {
                if quality.name == name {
                    return quality
                }
            }
        }
        
        return nil
    }

    func getIMDbRating() -> String {
        if let ratings = self.ratings {
            for rating in ratings {
                if rating.website == "IMDb" {
                    return String(describing: rating.rating)
                }
            }
        }

        return ""
    }
    
    func getLanguageByLocale(locale: String) -> Language? {
        let localeLowerCase = locale.lowerCase()

        if let languages = self.languages {
            for language in languages {
                if language.iso_639_2b == localeLowerCase {
                    return language
                }
            }
        }
        
        return nil
    }
    
    func fill(data: JSON) {
        self.type = data["type"].string!
        self.streamTemplate = data["stream_template"].string!
        self.subtitleTemplate = data["subtitle_template"].string!
        
        self.fillLanguages(languages: data["languages"])
        self.fillQualities(qualities: data["qualities"])
        self.fillSubtitles(subtitles: data["subtitles"])
        
        self.fillDetails(details: data["details"])
        
        self.fillRatings(ratings: data["ratings"])
        self.fillCelebrities(celebrities: data["celebrities"])
        
        if self.type == "series" {
            self.fillSeasons(seasons: data["seasons"])
        }
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
    
    func fillDetails(details: JSON) {
        self.details = Details()
        
        self.details!.releaseDate = details["release_date"].string
        self.details!.countries = details["countries"].arrayValue.map{$0.stringValue}
        self.details!.genres = details["genres"].arrayValue.map{$0.stringValue}
        self.details!.duration = details["duration"].string
        self.details!.directors = details["directors"].arrayValue.map{$0.stringValue}
        self.details!.screenwriters = details["screenwriters"].arrayValue.map{$0.stringValue}
        self.details!.network = details["network"].string
        self.details!.budget = details["budget"].string
        self.details!.income = details["income"].string
        self.details!.slogan = details["slogan"].string
        self.details!.overview = details["description"].string
    }
    
    func fillRatings(ratings: JSON) {
        var ratingsObj = [Rating]()
        
        for (_, rating) in ratings {
            ratingsObj.append(Rating(
                website: rating["website"].string!,
                url: rating["url"].string,
                icon: rating["icon"].string,
                rating: rating["rating"].float!
            ))
        }
        
        self.ratings = ratingsObj
    }
    
    func fillCelebrities(celebrities: JSON) {
        var celebritiesObj = [Celebrity]()
        
        for (_, celebrity) in celebrities {
            let celebrityObj = Celebrity()
            
            celebrityObj.nameGeo = celebrity["name_ka"].string
            celebrityObj.nameEng = celebrity["name_en"].string
            celebrityObj.image = celebrity["image"].string
            celebrityObj.url = celebrity["url"].string
            
            celebritiesObj.append(celebrityObj)
        }
        
        self.celebrities = celebritiesObj
    }
    
    func fillSeasons(seasons: JSON) {
        var seasonsObj = [Season]()
        
        for (_, season) in seasons {
            let seasonObj = Season()
            
            seasonObj.number = season["number"].int
            seasonObj.numberTrailed = season["number_trailed"].string
            seasonObj.numberOfEpisodes = season["number_of_episodes"].int
            
            seasonObj.fillEpisodes(episodes: season["episodes"])
            
            seasonsObj.append(seasonObj)
        }
        
        self.seasons = seasonsObj
    }
}
