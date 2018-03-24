//
//  ProfileViewController.swift
//  swiftCourse
//
//  Created by user on 22.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Foundation


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var birthdayField: UITextField!
    
    
    private var datePicker: UIDatePicker!
    private var userManager: UserManager!
    private var user: User!
    private let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        imagePicker.delegate = self
        configurePicker()
        birthdayField.inputView = datePicker
        userManager = UserManager()
        user = userManager.getCurrentUser()
        nameField.text = user.name
        
        let dateString: String
        if let date = user.birthday {
            let dateFormatter = DateFormatter()
            dateString = dateFormatter.string(from: date)
        } else {
            dateString = ""
        }        
        birthdayField.text = dateString
    }
    func configurePicker() {
        datePicker = UIDatePicker(frame: CGRect.zero)
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(onDatePickerChanged), for: UIControlEvents.valueChanged)
        
        let accView = UIView()
        accView.frame = CGRect(x: 0, y: 0, width: 0, height: 30)
        accView.layer.backgroundColor = UIColor.lightGray.cgColor
        
        let accButton = UIButton()
        accButton.setTitle("Done", for: .normal)
        accButton.frame = CGRect(x: self.view.frame.width - 50 - 20, y: 10, width: 50, height: 20)
        accButton.addTarget(self, action: #selector(onDatePickerDone), for: UIControlEvents.touchUpInside)
        accView.addSubview(accButton)
        birthdayField.inputAccessoryView = accView
        
        /*myView.backgroundColor = UIColor.gray
        myView.inputAccessoryView
        myButton.titleLabel?.text = "Hello World"
        //myButton.frame
        myButton.addTarget(self, action: #selector(), for: UIControlEvents.touchUpInside)*/
    }
    
    @IBAction func avatarSet(_ sender: Any) {
        let alert = UIAlertController(title: "Choose your image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let gal = UIAlertAction(title: <#T##String?#>, style: <#T##UIAlertActionStyle#>, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>)
        
        let galleryButton = UIAlertAction(title: "Galery", style: .default, {(action) in
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        let cameraButton = UIAlertAction(title: "Camera", style: .default, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>)
        let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>)
        alert.addAction(cameraButton)
        alert.addAction(cancelButton)
        alert.addAction(galleryButton)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func onDatePickerChanged(datePicker: UIDatePicker) {
        let date = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        birthdayField.text = dateFormatter.string(from: date)
        user.birthday = date
        userManager.change(user: user)
        
        avatarImage.image = user.avatar
        
    }
    @objc func onDatePickerDone(sender: Any) {
        self.view.endEditing(true)
    }
    func textFieldDidEditing(_ textField: UITextField) {
        if let text = textField.text, text.count > 0 {
            user.name = text
            userManager.change(user: user)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ProfileViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info["UImagePickerControllerOriginalImage"] as? UIImage
        avatarImage.image = image
        
        user.avatar = image
        userManager.change(user: user)
        
        dismiss(animated: true, completion: nil)
    }
    }

extension ProfileViewController: UITextFieldDelegate {
        func textFieldShouldReturn (_ textField: UITextField) -> Bool {
            textField.endEditing(true)
            return true
    }
}


