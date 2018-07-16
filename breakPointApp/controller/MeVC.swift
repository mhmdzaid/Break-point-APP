//
//  MeVC.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/11/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
class MeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var EmailLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.EmailLbl.text  = Auth.auth().currentUser?.email
        //check if current user has an image on the firebase
        DispatchQueue.global(qos: .userInteractive).sync {
            DataService.instance.getProfileImage(forUID: (Auth.auth().currentUser?.uid)!) { (returnedURL,imageExists) in
                if imageExists{
                    do{
                        let data = try Data(contentsOf: returnedURL!)
                        let image = UIImage(data: data)
                        self.ProfileImage.image = image
                    }
                    catch{}
                }else{
                    
                    self.ProfileImage.image = UIImage(named: "defaultProfileImage")
                }
            }
            
        }

    }
    
    
    @IBAction func uploadButtonPressed(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alert = UIAlertController(title: "Change photo", message: "choose your profile photo", preferredStyle: .actionSheet)
       
        alert.addAction(UIAlertAction(title: "take a photo  ", style: .default, handler: { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }else{
                print("camera not available")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "choose a photo ", style: .default, handler: { (_) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            imagePicker.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func SignOutBtnWasPressed(_ sender: Any) {
        let logoutPopUp = UIAlertController(title: "logout?", message: "Are you sure you want to logout !", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "logout?", style: .destructive) { (buttonTapped) in
            do{
              try Auth.auth().signOut()
               let AuthVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC")
               self.present(AuthVC!, animated: true, completion: nil)
            }catch{
                print(error.localizedDescription)
            }
        }
        logoutPopUp.addAction(logoutAction)
        present(logoutPopUp, animated: true, completion: nil)
    }
}

extension MeVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageURL = info[UIImagePickerControllerImageURL] as! URL
        DataService.instance.uploadImage(forUID: (Auth.auth().currentUser?.uid)!, imageURL: imageURL) { (completed) in
            if completed{
                print("uploaded successfully ")
            }else{
                print("something went wrong")
            }
        }
        self.ProfileImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
