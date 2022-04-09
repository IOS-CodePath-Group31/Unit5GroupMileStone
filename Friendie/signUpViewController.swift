//
//  signUpViewController.swift
//  Friendie
//
//  Created by Mimi Ogunyemi on 4/7/22.
//

import UIKit
import Parse

class signUpViewController: UIViewController {

    @IBOutlet weak var signUpUsernameField: UITextField!
    
    
    @IBOutlet weak var signUpPasswordField: UITextField!
    
    
    @IBAction func onSignUp(_ sender: Any) {
        
          let user = PFUser()
        user.username = signUpUsernameField.text
        user.password = signUpPasswordField.text
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "signUpSegue", sender: nil)
            }else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
   
    
    @IBAction func alternateLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "signUpSegue", sender: nil)
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
