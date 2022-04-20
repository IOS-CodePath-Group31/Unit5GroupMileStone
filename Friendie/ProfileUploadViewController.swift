//
//  ProfileUploadViewController.swift
//  Friendie
//
//  Created by Roger Liu on 4/16/22.
//

import UIKit
import AlamofireImage
import Alamofire
import Parse

class ProfileUploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func onSubmitButton(_ sender: Any) {
        let description = textField?.text as? String
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        let Profile = PFObject(className: "Profiles")
        
        Profile["description"] = description
        Profile["image"] = file
        Profile["author"] = PFUser.current()
        
        Profile.saveInBackground { (success, error) in
            if success {
                print("Saved")
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print("Failed to create the profile!")
            }
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
        
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
