//
//  Api.swift
//  AdjaraNet
//
//  Created by Irakli Tchitadze on 11/29/17.
//  Copyright © 2017 Irakli Tchitadze. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Api {
    
    class func getHeaders() -> [String: String] {
        return ["X-API-KEY": Api.getApiKey()]
    }
    
    class func getApiKey() -> String {
        return "0c90d869-fb89-11b4-2afb-15c7a4bb64ee"
    }
    
    class func getAllSectionsUrl() -> String {
        return "https://adjaranet.buglinjo.me/api/home-page/get/all"
    }
    
    class func getSearchUrl() -> String {
        return "https://adjaranet.buglinjo.me/api/search?q="
    }
    
    class func getVideoDetailsUrl(id: String) -> String {
        return "https://adjaranet.buglinjo.me/api/details/get/" + id
    }
    
    class func getStreamHeaders(id: String) -> [String: String] {
        return [
            "Host": "net.adjara.com",
            "Origin": "http://net.adjara.com",
            "Referer": "http://net.adjara.com/Movie/main?id=" + id,
        ]
    }
    
    class func getVideosFromJson(videosJson: JSON) -> [Video] {
        var videos = [Video]()
        
        for (_, video) in videosJson {
            var titles = [Title]()
            var images = [Image]()
            
            for (_, title) in video["titles"] {
                let language = Language(
                    name: title["language"]["name"].string!,
                    local: title["language"]["local"].string!,
                    iso_639_1: title["language"]["iso_639_1"].string!,
                    iso_639_2b: title["language"]["iso_639_2b"].string!
                )
                
                titles.append(Title(text: title["text"].string!.htmlUnescape(), language: language))
            }
            
            for (_, image) in video["images"] {
                let imageObj = Image(
                    size: image["size"].string!,
                    resolution: image["resolution"].string!,
                    url: image["url"].string!
                )
                
                images.append(imageObj)
            }
            
            videos.append(Video(id: video["id"].string!, titles: titles, images: images))
        }
        
        return videos
    }
    
    class func JSONRequest(url: String, headers: Dictionary<String, String>, completionHandler: @escaping (JSON?, Error?) -> ()) {
        Api.makeJSONCall(url, headers, completionHandler: completionHandler)
    }
    
    class func makeJSONCall(_ url: String, _ headers: Dictionary<String, String>, completionHandler: @escaping (JSON?, Error?) -> ()) {
        
        let reachability = Reachability()!
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        reachability.whenReachable = { reachability in
            if reachability.connection != .none {
                Alamofire.request(url, headers: headers).responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        completionHandler(JSON(value), nil)
                    case .failure(let error):
                        completionHandler(nil, error)
                    }
                }
            }
        }
    }
}
