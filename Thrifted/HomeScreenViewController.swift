//
//  HomeScreenViewController.swift
//  Thrifted
//
//  Created by Maloney, Grant P. (MU-Student) on 3/17/18.
//  Copyright © 2018 Maloney, Grant P. (MU-Student). All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var name: String = ""
    var email: String = ""
    var url: String = ""
    var gender: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Successfully Logged In!"
        
        if let profileURL = URL(string: url) {
            
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: profileURL) {
                    DispatchQueue.main.async {
                        self.userImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        self.nameLabel.text = "[\(gender)] \(name)"
        self.emailLabel.text = email
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
