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
