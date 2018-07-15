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
    
    func fetchVideos(completion: @escaping ([Video]) -> ()){
        let jsonUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        URLSession.shared.dataTask(with: URL(string: jsonUrl)!) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }else {
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
            }
            
        }.resume()
    }
    
}
