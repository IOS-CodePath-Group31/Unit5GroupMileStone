//
//  GroupDetailViewController.swift
//  Friendie
//
//  Created by Jibril Mohamed on 4/13/22.
//

import UIKit
import Parse


class GroupDetailViewController: UIViewController {
    
    var group: PFObject!

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupCreator: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let name = group["name"] as? String
        let user = group["author"] as! PFUser
        let author = user.username
        
        let imageFile = group["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        groupName?.text = name
        groupCreator?.text = author
        imageView.af.setImage(withURL: url)
        
        let groupauthor = group["author"] as? PFUser
        if groupauthor?.objectId != PFUser.current()?.objectId {
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.customView?.isHidden = true
        }
        }
        
    
    
    
    
 
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            
            print("Posts selected")
        case 1:
            print("Members selected")
        default:
            print("Default case")
        }
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // pass the selected group to the group details view controller
        let AddPeopleViewController = segue.destination as! AddPeopleViewController
        AddPeopleViewController.currentGroup = self.group
        
    }

}
