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

    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
               
       let main = UIStoryboard(name: "Main", bundle: nil)
       let loginViewController = main.instantiateViewController(withIdentifier: "loginViewController")
       
       guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       
               let delegate = windowScene.delegate as? SceneDelegate else { return }
       delegate.window?.rootViewController = loginViewController
       
       self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupTableView.delegate = self
        groupTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupTableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        cell.groupNameLabel?.text = "Best team ever!"
        cell.createdByLabel?.text = "Jibril"
        
        return cell
    }
    
}
