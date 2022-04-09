//
//  CreateGroupViewController.swift
//  Friendie
//
//  Created by Jibril Mohamed on 4/9/22.
//

import UIKit
import AlamofireImage
import Alamofire
import Parse

class CreateGroupViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var groupName: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCreateGroup(_ sender: Any) {
        let name = groupName?.text!
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        let Group = PFObject(className: "Groups")
        
        Group["name"] = name
        Group["image"] = file
        Group["author"] = PFUser.current()
        
        Group.saveInBackground { (success, error) in
            if success {
                print("Saved")
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print("Failed to create a Group!")
            }
        }
    }
    
    
    @IBAction func onImageViewTap(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
        
    }

}
