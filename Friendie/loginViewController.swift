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
              self.performSegue(withIdentifier: "FeedNavigationSegue", sender: nil)
          } else {
              print("Error: \(error?.localizedDescription)")
        }
        
        }
    }
    
    
        override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

