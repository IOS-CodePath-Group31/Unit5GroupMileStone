//
//  AddPeopleViewController.swift
//  Friendie
//
//  Created by Jibril Mohamed on 4/16/22.
//

import UIKit
import Parse

class AddPeopleViewController: UIViewController {

    @IBOutlet weak var addPeopleTextField: UITextField!
    var currentGroup: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.)
        print("Current Group: \(currentGroup)")
    }
    
    
    @IBAction func addPeopleToGroup(_ sender: Any) {
        let author = currentGroup["author"] as? PFUser
        if author?.objectId != PFUser.current()?.objectId {
            print("You are not the author of the group!")
            self.dismiss(animated: true, completion: nil)
            return
        }
        let personUsername = addPeopleTextField.text!
        print("Username entered: \(personUsername)")
        let query = PFUser.query()
        query?.whereKey("username", equalTo:personUsername)
        
        query?.findObjectsInBackground { (PFUser, error) in
            if (PFUser != nil) {
                self.currentGroup.add(PFUser, forKey: "members")
                print("Added person to Group: \(PFUser)")
            }
            else {
                print("Failed fetching user.")
            }
            
        }
        
        self.dismiss(animated: true, completion: nil)
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
