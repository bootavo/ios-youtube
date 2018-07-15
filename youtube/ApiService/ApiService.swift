//
//  ApiService.swift
//  youtube
//
//  Created by Gustavo Tufiño Fernandez on 7/15/18.
//  Copyright © 2018 GAP GLOBAL SOLUTIONS S.A.C. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()){
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json") { (videos) in
            completion(videos)
        }
    }
    
    func fetchTrending(completion: @escaping ([Video]) -> ()){
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json") { (videos) in
            completion(videos)
        }
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()){
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json") { (videos) in
            completion(videos)
        }
    }
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()){
        
        let jsonUrl = urlString
        URLSession.shared.dataTask(with: URL(string: jsonUrl)!) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print(json)
                
                var videos = [Video]()
                
                for dictionaryVideo in json as! [[String: AnyObject]]{
                    let video = Video()
                    video.title = dictionaryVideo["title"] as? String
                    video.thumbnailImageName = dictionaryVideo["thumbnail_image_name"] as? String
                    video.thumbnailImageName = dictionaryVideo["thumbnail_image_name"] as? String
                    video.views = dictionaryVideo["number_of_views"] as? NSNumber
                    
                    let dictionaryChannel = dictionaryVideo["channel"] as! [String: AnyObject]
                    let channel = Channel()
                    channel.name = dictionaryChannel["name"] as? String
                    channel.profileImageName = dictionaryChannel["profile_image_name"] as? String
                    
                    video.channel = channel
                    videos.append(video)
                }
                
                DispatchQueue.main.async {
                    completion(videos)
                }
                
            }catch let jsonError{
                print(jsonError)
            }
            
        }.resume()
        
    }
    
}
