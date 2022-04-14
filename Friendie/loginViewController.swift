//
//  loginViewController.swift
//  Friendie
//
//  Created by Mimi Ogunyemi on 4/6/22.
//

import UIKit
import Parse

class loginViewController: UIViewController {

    
    @IBOutlet weak var loginUsernameField: UITextField!
    
    
    @IBOutlet weak var loginPasswordField: UITextField!
    
    @IBAction func onLogin(_ sender: Any) {
        
        let username = loginUsernameField.text!
        let password = loginPasswordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) {
          (user, error) in
          if user != nil {
              UserDefaults.standard.set(true, forKey: "userLoggedIn")
              self.performSegue(withIdentifier: "feedViewController", sender: nil)
          } else {
              print("Error: \(error?.localizedDescription)")
        }
            
            
        
        }
    }
    
    
        override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
        override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            self.performSegue(withIdentifier: "feedViewController", sender: self)
       }
    }

}

