//
//  PostVC.swift
//  breakPointApp
//
//  Created by mohamed zead on 7/11/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
import Firebase
class PostVC: UIViewController {

    @IBOutlet weak var PostButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var UserImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        PostButton.bindToKeyBoard()
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.EmailLabel.text = Auth.auth().currentUser?.email
    }
    @IBAction func PostBtnWasPressed(_ sender: Any) {
        if textView.text != nil && textView.text != "Say somthing ..."{
            PostButton.isEnabled = false
            
            DataService.instance.UploadPost(withMessage: textView.text, forUID:(Auth.auth().currentUser?.uid)! , WithGroupKey: nil, UploadCompleted: { (completed) in
                if completed{
                    self.PostButton.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print("there was an error ")
                }
            })
        }
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}

extension PostVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.textView.text = ""
    }
}


