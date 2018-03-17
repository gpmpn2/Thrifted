//
//  ViewController.swift
//  Thrifted
//
//  Created by Maloney, Grant P. (MU-Student) on 3/17/18.
//  Copyright © 2018 Maloney, Grant P. (MU-Student). All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()
    
    let buttonText = NSAttributedString(string: "Login with Facebook")
    
    var name = ""
    var email = ""
    var url = ""
    var gender = ""
    //Turn this into an object of a person please...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        self.navigationItem.title = "Log In"
        
        loginButton.setAttributedTitle(buttonText, for: .normal)
        
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
        
        if let token = FBSDKAccessToken.current() {
            fetchProfile()
        }
    }
    
    func fetchProfile() {
        let parameters = ["fields": "email, first_name, last_name, gender, picture.type(large)"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start {
            (connection, result, error) -> Void in
            
            guard let result = result as? NSDictionary,
                let email = result["email"] as? String,
                let user_name = result["first_name"] as? String,
                let user_lastname = result["last_name"] as? String,
                let user_gender = result["gender"] as? String
            else {
                return
            }
            
            //Use this when we need to pull the users image data...
            if let picture = result["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary, let url = data["url"] as? String {
                self.url = url
            }
            
            self.name = "\(user_name) \(user_lastname)"
            self.email = email
            self.gender = user_gender
            
            self.performSegue(withIdentifier: "ShowHomeScreen", sender: nil)
        }
        
        self.loginButton.setAttributedTitle(NSAttributedString(string: "Logout of Facebook"), for: .normal)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        fetchProfile()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HomeScreenViewController {
            destination.name = self.name
            destination.email = self.email
            destination.url = self.url
            destination.gender = self.gender
            navigationItem.titleView?.backgroundColor = UIColor.black
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        logoutProfile()
    }
    
    func logoutProfile(){
        //TODO Logout
        self.loginButton.setAttributedTitle(NSAttributedString(string: "Login with Facebook"), for: .normal)
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

