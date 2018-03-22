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
            titleLabel.text = video?.title
            thumnailImageView.image = UIImage(named: (video?.thumbnailImageName)!)
            subtittleTexView.text =  (video?.title)! + " - " + (video?.views)! + " views  - 2 years"
        }
    }
    
    /*  How would you feel
        Dive
        Bloodstream
        Afire love
        One
        All of the stars
        Small bump
        Lego House
        The a team
        Give me love
        Photograph
        Perfect
        Thinking out loud
        MAGIC! - Rude
        One Republic - Counting stars
        Moves like Jagger
        Payphone
        One More Night
        Don't wanna know
        Sugar
        She will be loved
    */
    
    let thumnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named: "she_will_be_loved")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.green
        imageView.image = UIImage(named: "maroon_5")
        imageView.layer.cornerRadius = 22
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
        
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumnailImageView, userProfileImageView, separatorView)
        
        //Top constraints
        addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumnailImageView, attribute: .bottom, multiplier: 1, constant: 8)])
        
        //Left constraint
        addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8)])
        
        //Right constraint
        addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumnailImageView, attribute: .right, multiplier: 1, constant: 0)])
        
        //Height constraint
        addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)])
        
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
