//
//  feedViewController.swift
//  Friendie
//
//  Created by Mimi Ogunyemi on 4/6/22.
//

import UIKit
import Parse

class feedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var groupTableView: UITableView!
    
    var groups = [PFObject]()

    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
               
       let main = UIStoryboard(name: "Main", bundle: nil)
       let loginViewController = main.instantiateViewController(withIdentifier: "loginViewController")
       
       guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       
               let delegate = windowScene.delegate as? SceneDelegate else { return }
       delegate.window?.rootViewController = loginViewController
       
       self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupTableView.delegate = self
        groupTableView.dataSource = self
        // Do any additional setup after loading the view.
        loadGroups()
        print("Hello world!")
        print("Logged in user: \(PFUser.current()?.username)")
    }
    
    func loadGroups() {
        let query = PFQuery(className: "Groups")
        query.includeKey("author")
        query.limit = 5
        self.groups.removeAll()
        
        query.findObjectsInBackground { (groups, error) in
            if groups != nil {
                self.groups = groups!
                self.groupTableView.reloadData()
                print("Groups fetched successfully!")
                print(self.groups)
            } else {
                print("Failed fetching groups Data!")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Groups")
        print(self.groups)
        print("+++++++")
        return self.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupTableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        
        let group = self.groups[indexPath.row]
        
        let author = group["author"] as! PFUser
        let name = group["name"] as? String
        let imageFile = group["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.groupNameLabel?.text = name
        cell.createdByLabel?.text = author.username
        cell.groupImageView.af.setImage(withURL: url)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell else {
            return
        }
        let indexPath = groupTableView.indexPath(for: cell)!
        let group = self.groups[indexPath.row]
        print("Group: \(group)")
        // pass the selected group to the group details view controller
        let detailsViewController = segue.destination as! GroupDetailViewController
        detailsViewController.group = group
    }
    
}
