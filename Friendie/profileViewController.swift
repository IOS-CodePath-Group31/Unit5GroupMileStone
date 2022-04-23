//
//  profileViewController.swift
//  Friendie
//
//  Created by Roger Liu on 4/15/22.
//
import UIKit
import SwiftUI
import AlamofireImage
import Parse

class profileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var profiles = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
       // profileImage.layer.borderColor = UIColor.black.cgColor
       // profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
        let author = PFUser.current()
        let query = PFQuery(className: "Profiles")
        query.includeKey("author")
        query.limit = 1
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (profiles, error) in
            if profiles != nil {
                self.profiles = profiles!
                let profile = self.profiles[0]
                let author = profile["author"] as! PFUser
                let description = profile["description"] as? String
                let imageFile = profile["image"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
                
                self.usernameLabel?.text = author.username
                self.descriptionLabel?.text = description
                self.profileImage.af.setImage(withURL: url)
                
                print("Profiles fetched successfully!")
                print(self.profiles)
            } else {
                print("Failed fetching profiles!")
            }
        }

//        let description = profile["description"] as? String
//        let imageFile = profile["image"] as! PFFileObject
        
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
