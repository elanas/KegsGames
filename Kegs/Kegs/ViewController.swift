//
//  ViewController.swift
//  Kegs
//
//  Created by Elana Stroud on 11/24/16.
//  Copyright © 2016 com.Kegs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var titleLabel:UILabel!
    
    //Play Button Constants
    var playButton: UIButton!
    var playBtnWidth:CGFloat = Globals.screenWidth * 0.2
    var playBtnHeight:CGFloat = Globals.screenWidth * 0.2
    var notPlayBtnWidth:CGFloat = Globals.screenWidth * 0.5
    var notPlayBtnHeight:CGFloat = Globals.screenWidth * 0.5
    
    var notPlayingBtnColor:UIColor = UIColor(red: 248/255.0, green: 24/255.0, blue: 67/255.0, alpha: 1.0)
    var playingBtnColor:UIColor = UIColor(red: 50/255.0, green: 255/255.0, blue: 178/255.0, alpha: 1.0)
    
    var notPlayingTitleColor:UIColor = UIColor.white
    var playingTitleColor:UIColor = UIColor.black
    
    var notPlayingText:String = "Press To Play"
    var playingText:String = " Signoff "
    
    var notPlayBtnFontSize:CGFloat = 25
    var playFontBtnSize:CGFloat = 10

    //Swipe Views
    var swipeViewLeft:SwipeView!
    var swipeViewRight:SwipeView!
    var swipeViewCenter:SwipeView!
    var imageIndex: NSInteger = 1
    
    var swipeViews:[SwipeView]!
    
    var contactBtn:UIButton!
    
    var returningUser:Bool!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        
        returningUser = defaults.bool(forKey: "returningUser")

        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 35/255.0, green: 182/255.0, blue: 255/255.0, alpha: 1)
        
        //play button
        self.playButton = UIButton(frame: CGRect(x: Globals.getCenter(outer: Globals.screenWidth, inner: notPlayBtnWidth), y: Globals.getCenter(outer: Globals.screenHeight, inner: notPlayBtnHeight), width: notPlayBtnWidth, height: notPlayBtnHeight))
        self.playButton.layer.cornerRadius = 0.5 * self.playButton.bounds.size.width
        playButton.clipsToBounds = true
        playButton.addTarget(self, action: #selector(ViewController.pressPlayButton), for: UIControlEvents.touchUpInside)
        playButton.backgroundColor = notPlayingBtnColor
        //playButton.titleLabel?.font = playButton.titleLabel?.font.withSize(notPlayBtnFontSize)
        playButton.setTitle(notPlayingText, for: UIControlState.normal)
        
        //swipe view stuff
        let svW:CGFloat = Globals.screenWidth * 0.8
        let svH:CGFloat = Globals.screenHeight * 0.5
        let svX:CGFloat = Globals.getCenter(outer: Globals.screenWidth, inner: svW)
        let svY:CGFloat = Globals.getCenter(outer: Globals.screenHeight, inner: svH)
        swipeViewLeft = SwipeView(frame: CGRect(x: svX, y: svY, width: svW, height: svH))
        swipeViewRight = SwipeView(frame: CGRect(x: svX, y: svY, width: svW, height: svH))
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
        
        let contactBtnWidth:CGFloat = swipeViewCenter.frame.width
        let contactBtnHeight:CGFloat = 40
        let contactBtnX:CGFloat = svX
        let contactBtnY:CGFloat = svY + svH + 2
            
        contactBtn = UIButton(frame: CGRect(x:contactBtnX, y:contactBtnY, width: contactBtnWidth, height:contactBtnHeight))
        contactBtn.backgroundColor = UIColor.white
        contactBtn.layer.cornerRadius = 6
        contactBtn.setTitle("Setup a Game", for: UIControlState.normal)
        contactBtn.setTitleColor(UIColor.black.withAlphaComponent(0.8), for: UIControlState.normal)
        contactBtn.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        contactBtn.isHidden = true
        
        contactBtn.addTarget(self, action: #selector(contactPress), for: UIControlEvents.touchDown)
        contactBtn.addTarget(self, action: #selector(contactUnpress), for: UIControlEvents.touchUpInside)
        
        //title label
        let titleLabelWidth:CGFloat = Globals.screenWidth
        let titleLabelHeight:CGFloat = 30
        let titleLabelX:CGFloat = 0
        let titleLabelY:CGFloat = svY - titleLabelHeight - 30
            
        titleLabel = UILabel(frame: CGRect(x:titleLabelX, y:titleLabelY, width: titleLabelWidth, height:titleLabelHeight))
        titleLabel.text = "Players Near You:"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont(name: "Avenir", size: 25)
        titleLabel.isHidden = true
        
        self.view.addSubview(playButton)
        self.view.addSubview(contactBtn)
        self.view.addSubview(titleLabel)
    }
    
    func contactPress() {
        self.contactBtn.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        
        contactBtn.setTitle("Request Pending...", for: UIControlState.normal)
        
        //TODO: logic for contacting other play about request

        
    }
    
    func contactUnpress() {
        self.contactBtn.backgroundColor = UIColor.white
    }
    
    func pressPlayButton() {
        
        //not playing
        if playButton.backgroundColor == playingBtnColor {
            playButton.backgroundColor = notPlayingBtnColor
            playButton.setTitleColor(notPlayingTitleColor, for: UIControlState.normal)
            playButton.setTitle(notPlayingText, for: UIControlState.normal)
            
            self.contactBtn.isHidden = true
            self.titleLabel.isHidden = true
            UIView.animate(withDuration: 1.0, animations:{
                self.swipeViewCenter.removeFromSuperview()
                self.playButton.frame = CGRect(x: Globals.getCenter(outer: Globals.screenWidth, inner: self.notPlayBtnWidth), y: Globals.getCenter(outer: Globals.screenHeight, inner: self.notPlayBtnHeight), width: self.notPlayBtnWidth, height: self.notPlayBtnHeight)
                self.playButton.titleLabel?.font = UIFont(name: UIFont.systemFont(ofSize: 8).fontName, size: self.notPlayBtnFontSize)
                self.playButton.layer.cornerRadius = 0.5 * self.playButton.bounds.size.width
            }, completion: {
                (value: Bool) in
            })
        
            
        }
        
        //playing
        else {
            
            if defaults.bool(forKey: "returningUser") == false {
                
                let infoVC:InfoViewController = InfoViewController()
                
                self.present(infoVC, animated: true, completion: {
                    
                })
                
                
                playButton.backgroundColor = playingBtnColor
                playButton.setTitleColor(playingTitleColor, for: UIControlState.normal)
                playButton.setTitle("Save", for: UIControlState.normal)
                
                let pX: CGFloat = Globals.screenWidth - self.playBtnWidth - 15
                let pY: CGFloat = Globals.screenHeight - self.playBtnHeight - 15
                
                UIView.animate(withDuration: 1.0, animations:{
                    self.playButton.frame = CGRect(x: pX, y:pY, width: self.playBtnWidth, height: self.playBtnHeight)
                    self.playButton.layer.cornerRadius = 0.5 * self.playButton.bounds.size.width
                    self.playButton.titleLabel?.font = UIFont(name: UIFont.systemFont(ofSize: 8).fontName, size: self.playFontBtnSize)
                    
                }, completion: {
                    (value:Bool) in
                    self.view.addSubview(self.swipeViewCenter)
                    self.contactBtn.isHidden = false
                    self.titleLabel.isHidden = false
                })
                
                return
            }
            
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
                self.contactBtn.isHidden = false
                self.titleLabel.isHidden = false
            })
            
        }
    }
    
    func resetContactButton() {
        //TODO: this should be setup by pulling from the server info about the user
        self.contactBtn.setTitle("Setup Game", for: UIControlState.normal)
    }
    
    func swiped(gesture: UIGestureRecognizer) {
        
        self.resetContactButton()
        
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

