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

    var homeController: HomeController?
    
    var videos:[Video]?
    
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
                    
                    self .videos = [Video]()
                    
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
                        self.videos?.append(video)
                    }
                    
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                    
                }catch let jsonError{
                    print(jsonError)
                }
            }
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("---------------------> 1")
        fetchVideos()
        print("---------------------> 2")
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
        print("---------------------> 3")
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
    
    lazy var settingsLancher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    let settingsLauncher = SettingsLauncher()
    @objc func handleMore() {
        print("more")
        settingsLauncher.homeController = self
        settingsLauncher.showSettings()
    }
    
    func showControllersForSettings(setting: Setting){
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
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
        return videos?.count ?? 0
    }	
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        
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
