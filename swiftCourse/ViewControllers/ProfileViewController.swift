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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var avatarImage: UIImageView!
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
        userManager.delegate = self
        setupNotifications()
        
        userManager.getUser { (user) in
            self.configureUI(user)
        }
        
        /*DispatchQueue.global().async {
            let newUser = self.userManager.user
            DispatchQueue.main.async {
                self.configureUI(newUser)
            }
        }*/
        /*DispatchQueue.global().async {
            let myUser = self.userManager.user
            DispatchQueue.main.async {
                self.nameField.text = myUser.name
                let dateString: String
                if let date = myUser.birthDay {
                    self.datePicker.date = date
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    dateString = dateFormatter.string(from: date)
                } else {
                    dateString = ""
                }
                self.birthdayField.text = dateString
                self.avatarImage.image = myUser.avatar
            }
        }*/
    }
    func configureUI(_ user: User) {
        avatarImage.image = user.avatar
        nameField.text = user.name
        let dateString: String
        if let date = user.birthDay {
            self.datePicker.date = date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateString = dateFormatter.string(from: date)
        } else {
            dateString = ""
        }
        birthdayField.text = dateString
    }
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.letters
        let allowedWhitespaces = CharacterSet.whitespaces
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet) || allowedWhitespaces.isSuperset(of: characterSet)
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
        accButton.frame = CGRect(x: self.view.frame.width - 70, y: 10, width: 50, height: 10)
        accButton.addTarget(self, action: #selector(onDatePickerDone), for: UIControlEvents.touchUpInside)
        accView.addSubview(accButton)
        birthdayField.inputAccessoryView = accView
        
        avatarImage.layer.cornerRadius = avatarImage.frame.width/2
        avatarImage.layer.borderColor = UIColor.black.cgColor
        avatarImage.layer.borderWidth = 2
        avatarImage.layer.masksToBounds = true
    }
    @objc func keyBoardWillShow(notifications: NSNotification) {
        if let keyboardFrame = (notifications.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            var inset = scrollView.contentInset
            inset.bottom = keyboardFrame.size.height
            scrollView.isScrollEnabled = true
            scrollView.contentInset = inset
        }
    }
    @objc func keyBoardWillHide(notifications: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.contentOffset = CGPoint.zero
        scrollView.isScrollEnabled = true
    }
    @IBAction func avatarSet(_ sender: Any) {
        let alert = UIAlertController(title: "Choose your image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let galleryButton = UIAlertAction(title: "Gallery", style: .default, handler: {(action) in
            self.present(self.imagePicker, animated: true, completion: nil)})
        let cameraButton = UIAlertAction(title: "Camera", style: .default)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(galleryButton)
        alert.addAction(cameraButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    @objc func onDatePickerChanged(datePicker: UIDatePicker) {
        let date = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        birthdayField.text = dateFormatter.string(from: date)
        userManager.user.birthDay = date
    }
    @objc func onDatePickerDone(sender: Any) {
        self.view.endEditing(true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.count > 0 {
            userManager.user.name = text
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            avatarImage.image = image
            userManager.user.avatar = image
            dismiss(animated: true, completion: nil)
        }
    }
}
extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
extension ProfileViewController: UserManagerDelegate {
    func uiDidChange() {
        userManager.setUser(for: userManager.user)
        print("Hey, UI did changed! Let`s do something!")
    }
}

