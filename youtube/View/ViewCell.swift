//
//  ViewCell.swift
//  youtube
//
//  Created by admin on 22/03/18.
//  Copyright © 2018 GAP GLOBAL SOLUTIONS S.A.C. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell {
    
    var video:Video? {
        didSet {
            if let title = video?.title {
                titleLabel.text = title
            }
            
            setupThumbnailImage()
            setupProfileImage()
            
            if let profileImage = video?.channel?.profileImageName {
                userProfileImageView.image = UIImage(named: profileImage)
            }
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.views {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                subtittleTexView.text = "\(channelName) • \(numberFormatter.string(from: numberOfViews)!) • 2 years "
            }
            
            //Measure title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimateRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimateRect.size.height > 20 {
                    titleLabelHeighConstraint?.constant = 44
                } else {
                    titleLabelHeighConstraint?.constant = 20
                }
                
            }
            
        }
    }
    
    func setupThumbnailImage(){
        if let thumbnailImageUrl = video?.thumbnailImageName {
            self.thumnailImageView.loadImageFromUrl(urlString: thumbnailImageUrl)
        }
    }
    
    func setupProfileImage(){
        if let profileImageUrl = video?.channel?.profileImageName {
            self.userProfileImageView.loadImageFromUrl(urlString: profileImageUrl)
        }
    }
    
    let thumnailImageView: CustomImageVIew = {
        let imageView = CustomImageVIew()
        imageView.image = UIImage(named: "she_will_be_loved")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: CustomImageVIew = {
        let imageView = CustomImageVIew()
        imageView.image = UIImage(named: "maroon_5")
        imageView.layer.cornerRadius = 22
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Maroon 5 - She will be loved"
        label.numberOfLines = 2
        return label
    }()
    
    let subtittleTexView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Maroon 5 VEVO - 1,890,345,53535 views - 2 years"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var titleLabelHeighConstraint: NSLayoutConstraint?
    
    override func setupViews(){
        //backgroundColor = UIColor.blue
        
        addSubview(thumnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtittleTexView)
        
        //Horizontal constraints
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumnailImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        //Vertical
        //First vertical constraint with two elements
        //addConstraintsWithFormat(format: "V:|-16-[v0]-16-[v1(1)]|", views: thumnailImageView, separatorView)
        
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumnailImageView, userProfileImageView, separatorView) // 16 -> V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|was changed to 36
        
        //Top constraints
        addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumnailImageView, attribute: .bottom, multiplier: 1, constant: 8)])
        
        //Left constraint
        addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8)])
        
        //Right constraint
        addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumnailImageView, attribute: .right, multiplier: 1, constant: 0)])
        
        //Height constraint
        
        titleLabelHeighConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        
        //addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .height, //relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)])
        
        //
        
        //Top constraints
        addConstraints([NSLayoutConstraint(item: subtittleTexView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4)])
        
        //Left constraint
        addConstraints([NSLayoutConstraint(item: subtittleTexView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8)])
        
        //Right constraint
        addConstraints([NSLayoutConstraint(item: subtittleTexView, attribute: .right, relatedBy: .equal, toItem: thumnailImageView, attribute: .right, multiplier: 1, constant: 0)])
        
        //Height constraint
        addConstraints([NSLayoutConstraint(item: subtittleTexView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30)])
        
    }
    
}
