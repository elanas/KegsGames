//
//  SwipeView.swift
//  Kegs
//
//  Created by Elana Stroud on 11/24/16.
//  Copyright © 2016 com.Kegs. All rights reserved.
//

import UIKit

class SwipeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
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
