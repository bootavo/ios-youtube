//
//  ViewController.swift
//  youtube
//
//  Created by admin on 22/03/18.
//  Copyright © 2018 GAP GLOBAL SOLUTIONS S.A.C. All rights reserved.
//

import UIKit
import Foundation

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var videos:[Video] = {
        
        // She will be loved
        var maroon_5_channel = Channel()
        maroon_5_channel.name = "Maroon 5"
        maroon_5_channel.profileImageName = "maroon_5"
        
        var she_will_be_loved = Video()
        she_will_be_loved.title = "Maroon 5 - She will be loved"
        she_will_be_loved.thumbnailImageName = "she_will_be_loved"
        she_will_be_loved.views = 53452234
        she_will_be_loved.channel = maroon_5_channel
        she_will_be_loved.uploadDate = "8 years"
        
        // This love
        var this_love = Video()
        this_love.title = "Maroon 5 - This love"
        this_love.thumbnailImageName = "this_love"
        this_love.views = 35344345
        this_love.channel = maroon_5_channel
        this_love.uploadDate = "6 years"
        
        // Don't look back in anger
        var oasis_channel = Channel()
        oasis_channel.name = "Oasis"
        oasis_channel.profileImageName = "oasis"
        
        var dont_look_back_in_anger = Video()
        dont_look_back_in_anger.title = "Oasis - Don't look back in anger Asdsb dsabdasd ibdoias"
        dont_look_back_in_anger.thumbnailImageName = "dont_look_back_in_anger"
        dont_look_back_in_anger.views = 12244235
        dont_look_back_in_anger.channel = oasis_channel
        dont_look_back_in_anger.uploadDate = "6 years"
        
        return [she_will_be_loved, this_love, dont_look_back_in_anger]
    }()
    
    var vide: Video?
    
    func fetchVideos(){
        
        let jsonUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        URLSession.shared.dataTask(with: URL(string: jsonUrl)!) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }else {
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    print(json)
                    
                    for dictionary in json as! [[String: AnyObject]]{
                        print(dictionary["title"]!)
                    }
                    
                }catch let jsonError{
                    print(jsonError)
                }
                
                /*
                do {
                    let str = String(data: data!, encoding: .utf8)
                    print(str)
                    //let json = try JSONDecoder().decode(vide.self, from: data!)
                    //self.info = json
                } catch {
                    print("didnt work")
                }*/
            }
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        //navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [searchBarButtonItem, moreButton]
    }
    
    @objc func handleSearch() {
        print("search")
    }
    
    @objc func handleMore() {
        print("more")
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }	
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        cell.video = videos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88) // 68 from Vertical constraints -> was change to 88
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
