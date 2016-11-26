//
//  SwipeView.swift
//  Kegs
//
//  Created by Elana Stroud on 11/24/16.
//  Copyright © 2016 com.Kegs. All rights reserved.
//

import UIKit

class SwipeView: UIView {

    var selfie:UIImageView!
    var nameLabel:UILabel!
    var distLabel:UILabel!
    var commentsLabel:UITextView!
    
    override init(frame: CGRect) {
        UILabel.appearance().font = UIFont(name: "Avenir", size: 15)
        
        super.init(frame: frame)
        backgroundColor = UIColor(red: 118/255.0, green: 207/255.0, blue: 255/255.0, alpha: 1)
        layer.cornerRadius = 5
        
        let selfieWidth:CGFloat = frame.width * 0.45
        let selfieHeight:CGFloat = selfieWidth * Globals.screenRatio
        let selfieX:CGFloat = 10
        let selfieY:CGFloat = Globals.getCenter(outer: self.frame.height, inner: selfieHeight)
            
        selfie = UIImageView(frame: CGRect(x:selfieX, y:selfieY, width: selfieWidth, height:selfieHeight))
        selfie.image = UIImage(named: "camilla.png")
        selfie.layer.cornerRadius = 6
        selfie.layer.masksToBounds = true
        
        let nameLabelWidth:CGFloat = frame.width * 0.45
        let nameLabelHeight:CGFloat = 20
        let nameLabelX:CGFloat = (frame.width * 0.75) - (nameLabelWidth/2)
        let nameLabelY:CGFloat = selfieY + 10
            
        nameLabel = UILabel(frame: CGRect(x:nameLabelX, y:nameLabelY, width: nameLabelWidth, height:nameLabelHeight))
        nameLabel.text = "Camilla Dohlman"
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        let distYMargin:CGFloat = 30
        let distLabelWidth:CGFloat = nameLabelWidth
        let distLabelHeight:CGFloat = nameLabelHeight
        let distLabelX:CGFloat = (frame.width * 0.75) - (distLabelWidth/2)
        let distLabelY:CGFloat = nameLabelY + nameLabelHeight + distYMargin
            
        distLabel = UILabel(frame: CGRect(x:distLabelX, y:distLabelY, width: distLabelWidth, height:distLabelHeight))
        
        distLabel.text = "0.5 miles away"
        distLabel.adjustsFontSizeToFitWidth = true
        distLabel.textAlignment = NSTextAlignment.center
        
        let commentMargin:CGFloat = 30
        let commentsLabelWidth:CGFloat = nameLabelWidth
        let commentsLabelX:CGFloat = (frame.width * 0.75) - (commentsLabelWidth/2)
        let commentsLabelY:CGFloat = distLabelY + distLabelHeight + commentMargin
        let commentsLabelHeight:CGFloat = (frame.height - commentsLabelY) - 5
        
        commentsLabel = UITextView(frame: CGRect(x:commentsLabelX, y:commentsLabelY, width: commentsLabelWidth, height:commentsLabelHeight))
        
        commentsLabel.text = "• Catan \n • Resistance \n • Avalon"
        commentsLabel.adjustsFontForContentSizeCategory = true
        commentsLabel.textAlignment = NSTextAlignment.center
        commentsLabel.backgroundColor = UIColor.clear
        commentsLabel.font = UIFont(name: "Avenir", size: 20)
        
        self.addSubview(selfie)
        self.addSubview(nameLabel)
        self.addSubview(distLabel)
        self.addSubview(commentsLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
