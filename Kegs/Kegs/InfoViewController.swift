//
//  InfoViewController.swift
//  Kegs
//
//  Created by Elana Stroud on 11/26/16.
//  Copyright © 2016 com.Kegs. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    var titleLabel:UILabel!
    
    var nameField:UITextField!
    var gamesField:UITextField!
    
    var continueBtn:UIButton!
    
    var imagePicker: UIImagePickerController!
    
    var profilePic:UIImageView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title label
        let titleLabelWidth:CGFloat = Globals.screenWidth
        let titleLabelHeight:CGFloat = 30
        let titleLabelX:CGFloat = 0
        let titleLabelY:CGFloat = Globals.screenHeight * 0.1
        
        titleLabel = UILabel(frame: CGRect(x:titleLabelX, y:titleLabelY, width: titleLabelWidth, height:titleLabelHeight))
        titleLabel.text = "Profile"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont(name: "Avenir", size: 25)
        titleLabel.textColor = UIColor.white
        
        self.view.backgroundColor = UIColor(red: 35/255.0, green: 182/255.0, blue: 255/255.0, alpha: 1)

        //namefield
        
        let nameFieldWidth:CGFloat = Globals.screenWidth * 0.8
        let nameFieldHeight:CGFloat = 26
        let nameFieldX:CGFloat = Globals.getCenter(outer: Globals.screenWidth, inner: nameFieldWidth)
        let nameFieldY:CGFloat = titleLabelY + Globals.screenHeight * 0.1
            
        nameField = UITextField(frame: CGRect(x:nameFieldX, y:nameFieldY, width: nameFieldWidth, height:nameFieldHeight))
        //nameField.placeholder = "Name or username"
        
        let nameborder = CALayer()
        let namewidth = CGFloat(1.0)
        nameborder.borderColor = UIColor.white.withAlphaComponent(0.7).cgColor
        nameborder.frame = CGRect(x: 0, y: nameField.frame.size.height - namewidth, width:  nameField.frame.size.width, height: nameField.frame.size.height)
        nameField.attributedPlaceholder = NSAttributedString(string:"Name or username",
                                                               attributes:[NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7)])
        
        nameborder.borderWidth = namewidth
        nameField.layer.addSublayer(nameborder)
        nameField.layer.masksToBounds = true
        nameField.textColor = UIColor.white
        
        //gamefield
        
        let gameMargin:CGFloat = Globals.screenHeight * 0.08
        let gameFieldWidth:CGFloat = Globals.screenWidth * 0.7
        let gameFieldHeight:CGFloat = 26
        let gameFieldX:CGFloat = Globals.getCenter(outer: Globals.screenWidth, inner: nameFieldWidth)
        let gameFieldY:CGFloat = nameFieldY + nameFieldHeight + gameMargin
        
        gamesField = UITextField(frame: CGRect(x:gameFieldX, y:gameFieldY, width: gameFieldWidth, height:gameFieldHeight))
        //nameField.placeholder = "Name or username"
        
        
        let gameborder = CALayer()
        let gamewidth = CGFloat(1.0)
        gameborder.borderColor = UIColor.white.withAlphaComponent(0.7).cgColor
        gameborder.frame = CGRect(x: 0, y: gamesField.frame.size.height - gamewidth, width:  gamesField.frame.size.width, height: gamesField.frame.size.height)
        gamesField.attributedPlaceholder = NSAttributedString(string:"Top three games (use commas)",
                                                             attributes:[NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7)])
        
        gameborder.borderWidth = gamewidth
        gamesField.layer.addSublayer(gameborder)
        gamesField.layer.masksToBounds = true
        gamesField.textColor = UIColor.white
        
        let continueButtonWidth:CGFloat = nameFieldWidth
        let continueButtonHeight:CGFloat = 36
        let continueButtonX:CGFloat = nameFieldX
        let continueButtonY:CGFloat = gameFieldY + gameFieldHeight + gameMargin
            
        continueBtn = UIButton(frame: CGRect(x:continueButtonX, y:continueButtonY, width: continueButtonWidth, height:continueButtonHeight))
        
        continueBtn.backgroundColor = UIColor.white
        continueBtn.setTitle("Continue", for: UIControlState.normal)
        continueBtn.setTitleColor(UIColor.black.withAlphaComponent(0.6), for: UIControlState.normal)
        continueBtn.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        
        continueBtn.addTarget(self, action: #selector(continuePress), for: UIControlEvents.touchDown)
        continueBtn.addTarget(self, action: #selector(continueUnpress), for: UIControlEvents.touchUpInside)
        
        let profilePicWidth:CGFloat = Globals.screenWidth * 0.3
        let profilePicHeight:CGFloat = profilePicWidth * (Globals.screenRatio - 0.3)
        let profilePicX:CGFloat = Globals.getCenter(outer: Globals.screenWidth, inner: profilePicWidth)
        let profilePicY:CGFloat = continueButtonY + continueButtonHeight + gameMargin
            
        profilePic = UIImageView(frame: CGRect(x:profilePicX, y:profilePicY, width: profilePicWidth, height:profilePicHeight))
        //profilePic.backgroundColor = UIColor.red
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(nameField)
        self.view.addSubview(gamesField)
        self.view.addSubview(continueBtn)
        self.view.addSubview(profilePic)
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
    }

    func continuePress() {
        self.continueBtn.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        
        
        //TODO: logic for contacting other play about request
        
        
    }
    
    func continueUnpress() {
        self.continueBtn.backgroundColor = UIColor.white
        
        if self.profilePic.image == nil {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            
            present(imagePicker, animated: true, completion: nil)

        } else {
            let name: String = nameField.text!
            let games: String = gamesField.text!

            defaults.set(name, forKey: "name")
            defaults.set(games, forKey: "games")
            defaults.set(true, forKey: "returningUser")
            
            self.dismiss(animated: true, completion: {
                print("dismissed")
            })
            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePic.contentMode = .scaleAspectFit
            profilePic.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
