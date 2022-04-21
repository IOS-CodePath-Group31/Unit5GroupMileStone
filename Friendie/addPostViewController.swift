//
//  addPostViewController.swift
//  Friendie
//
//  Created by Surya Patil on 4/16/22.
//

import UIKit
import AlamofireImage
import Alamofire
import Parse

class addPostViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postDescription: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func post(_ sender: Any) {

        let description = postDescription?.text as? String
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        let Post = PFObject(className: "Posts")
        
        Post["description"] = description
        Post["image"] = file
        Post["author"] = PFUser.current()
        
        Post.saveInBackground { (success, error) in
                    if success {
                        print("Saved")
                        self.dismiss(animated: true, completion: nil)
                    }
                    else {
                        print("Failed to create a Post!")
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
