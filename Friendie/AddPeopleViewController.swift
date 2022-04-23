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
    }
    
    
    @IBAction func addPeopleToGroup(_ sender: Any) {
        let author = currentGroup["author"] as? PFUser
        if author?.objectId != PFUser.current()?.objectId {
            print("You are not the author of the group!")
            self.dismiss(animated: true, completion: nil)
            return
        }
        let personUsername = addPeopleTextField.text!
        let query = PFUser.query()
        query?.whereKey("username", equalTo:personUsername)
        
        if personUsername != "" {
            print("Username entered: \(personUsername)")
            query?.findObjectsInBackground { (PFUser, error) in
                if (PFUser != nil) {
//                    PFUser["group"] = self.currentGroup
                    var NewMember = PFObject(className: "newMembers")
                    NewMember["author"] = PFUser
                    NewMember["name"] = personUsername
                    NewMember["group"] = self.currentGroup
                    self.currentGroup.add(NewMember, forKey: "newMembers")
                    print("Added person to Group: \(String(describing: PFUser))")
                    self.currentGroup.saveInBackground { (success, error) in
                        if success {
                            print("User added sucessfully!")
                        }
                        else {
                            print("Failed to add user.")
                        }
                        
                    }
                }
                else {
                    print("Not a valid user")
                }
                
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        else {
            print("This field cannot be empty!")
        }
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
