//
//  ChangeProfilePicViewController.swift
//  insta
//
//  Created by Tu Le
//

import UIKit
import Parse

class ChangeProfilePicViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCamera(_ sender: Any) {
    
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
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
    
    @IBAction func onYes(_ sender: Any) {
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        var user = PFUser.current()!
        user["profile_pic"] = file
        
        user.saveInBackground {
            (success, error) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                    print("saved your profile pic!")
                } else {
                    print("can't save your profile pic :(")
                }
        }
                    
                
        
    }
    
    @IBAction func onNo(_ sender: Any) {
        
        
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
