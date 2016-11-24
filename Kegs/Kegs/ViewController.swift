//
//  ViewController.swift
//  Kegs
//
//  Created by Elana Stroud on 11/24/16.
//  Copyright © 2016 com.Kegs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Play Button Constants
    var playButton: UIButton!
    var playBtnWidth:CGFloat = Globals.screenWidth * 0.2
    var playBtnHeight:CGFloat = Globals.screenWidth * 0.2
    var notPlayBtnWidth:CGFloat = Globals.screenWidth * 0.5
    var notPlayBtnHeight:CGFloat = Globals.screenWidth * 0.5
    
    var notPlayingBtnColor:UIColor = UIColor(red: 248/255.0, green: 24/255.0, blue: 67/255.0, alpha: 1.0)
    var playingBtnColor:UIColor = UIColor(red: 0/255.0, green: 255/255.0, blue: 81/255.0, alpha: 1.0)
    
    var notPlayingTitleColor:UIColor = UIColor.white
    var playingTitleColor:UIColor = UIColor.black
    
    var notPlayingText:String = "Press To Play"
    var playingText:String = " Game On "
    
    var notPlayBtnFontSize:CGFloat = 25
    var playFontBtnSize:CGFloat = 10

    //Swipe Views
    var swipeViewLeft:SwipeView!
    var swipeViewRight:SwipeView!
    var swipeViewCenter:SwipeView!
    var imageIndex: NSInteger = 1
    
    var swipeViews:[SwipeView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        //play button
        self.playButton = UIButton(frame: CGRect(x: Globals.getCenter(outer: Globals.screenWidth, inner: notPlayBtnWidth), y: Globals.getCenter(outer: Globals.screenHeight, inner: notPlayBtnHeight), width: notPlayBtnWidth, height: notPlayBtnHeight))
        self.playButton.layer.cornerRadius = 0.5 * self.playButton.bounds.size.width
        playButton.clipsToBounds = true
        playButton.addTarget(self, action: #selector(ViewController.pressPlayButton), for: UIControlEvents.touchUpInside)
        playButton.backgroundColor = notPlayingBtnColor
        //playButton.titleLabel?.font = playButton.titleLabel?.font.withSize(notPlayBtnFontSize)
        playButton.setTitle(notPlayingText, for: UIControlState.normal)
        
        //swipe view stuff
        let svW:CGFloat = 200
        let svH:CGFloat = 200
        let svX:CGFloat = Globals.getCenter(outer: Globals.screenWidth, inner: svW)
        let svY:CGFloat = Globals.getCenter(outer: Globals.screenHeight, inner: svH)
        swipeViewLeft = SwipeView(frame: CGRect(x: svX, y: svY, width: svW, height: svH))
        swipeViewLeft.backgroundColor = UIColor.green
        swipeViewRight = SwipeView(frame: CGRect(x: svX, y: svY, width: svW, height: svH))
        swipeViewRight.backgroundColor = UIColor.blue
        swipeViewCenter = SwipeView(frame: CGRect(x: svX, y: svY, width: svW, height: svH))
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(gesture:))) // put : at the end of method name
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(gesture:))) // put : at the end of method name
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        swipeViews = [SwipeView]()
        swipeViews.append(swipeViewLeft)
        swipeViews.append(swipeViewCenter)
        swipeViews.append(swipeViewRight)
        
        self.view.addSubview(playButton)
    }
    
    func pressPlayButton() {
        
        //not playing
        if playButton.backgroundColor == playingBtnColor {
            playButton.backgroundColor = notPlayingBtnColor
            playButton.setTitleColor(notPlayingTitleColor, for: UIControlState.normal)
            playButton.setTitle(notPlayingText, for: UIControlState.normal)
            
            
            UIView.animate(withDuration: 1.0, animations:{
                self.swipeViewCenter.removeFromSuperview()
                self.playButton.frame = CGRect(x: Globals.getCenter(outer: Globals.screenWidth, inner: self.notPlayBtnWidth), y: Globals.getCenter(outer: Globals.screenHeight, inner: self.notPlayBtnHeight), width: self.notPlayBtnWidth, height: self.notPlayBtnHeight)
                self.playButton.layer.cornerRadius = 0.5 * self.playButton.bounds.size.width
                self.playButton.titleLabel?.font = UIFont(name: UIFont.systemFont(ofSize: 8).fontName, size: self.notPlayBtnFontSize)
            }, completion: {
                (value: Bool) in
            })
        
            
        }
        
        //playing
        else {
            playButton.backgroundColor = playingBtnColor
            playButton.setTitleColor(playingTitleColor, for: UIControlState.normal)
            playButton.setTitle(playingText, for: UIControlState.normal)
            
            let pX: CGFloat = Globals.screenWidth - self.playBtnWidth - 15
            let pY: CGFloat = Globals.screenHeight - self.playBtnHeight - 15
            
            UIView.animate(withDuration: 1.0, animations:{
                self.playButton.frame = CGRect(x: pX, y:pY, width: self.playBtnWidth, height: self.playBtnHeight)
                self.playButton.layer.cornerRadius = 0.5 * self.playButton.bounds.size.width
                self.playButton.titleLabel?.font = UIFont(name: UIFont.systemFont(ofSize: 8).fontName, size: self.playFontBtnSize)

            }, completion: {
                (value:Bool) in
                self.view.addSubview(self.swipeViewCenter)

            })
            
        }
    }
    
    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.right :
                print("User swiped right")
                
                // decrease index first
                
                imageIndex -= 1
                
                // check if index is in range
                
                if imageIndex < 0 {
                    
                    imageIndex = 2
                    
                }
                self.swipeViewCenter.removeFromSuperview()
                self.swipeViewCenter = swipeViews[imageIndex]
                self.view.addSubview(swipeViewCenter)
                
            case UISwipeGestureRecognizerDirection.left:
                print("User swiped Left")
                
                // increase index first
                imageIndex += 1
                
                // check if index is in range
                
                if imageIndex > 2 {
                    
                    imageIndex = 0
                    
                }
                self.swipeViewCenter.removeFromSuperview()
                self.swipeViewCenter = swipeViews[imageIndex]
                self.view.addSubview(swipeViewCenter)
                
            default:
                break //stops the code/codes nothing.
                
                
            }
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

