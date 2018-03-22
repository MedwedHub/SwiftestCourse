//
//  ProfileViewController.swift
//  swiftCourse
//
//  Created by user on 22.03.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit



class ProfileViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var birthdayField: UITextField!
    
    private var datePicker: UIDatePicker!
    private let userManager = UserManager()
    private var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.delegate = self
        
        configurePicker()
        
        birthdayField.inputView = datePicker
        
        user = userManager.getCurrentUser()
        nameField.text = user.name
        
        let dateString: String
        
        if let date = user.birthday {
            dateString = DateFormatter.string(date)
        } else {
            dateString = ""
        }
        
        birthdayField.text = dateString
    }
    
    func configurePicker() {
        datePicker = UIDatePicker(frame: CGRect.zero)
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(onDatePickerChanged), for: UIControlEvents.valueChanged )
    }
    
    @objc func onDatePickerChanged(datePicker: UIDatePicker) {
        
        let date = datePicker.date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-yyy"
        
        let dateString = dateFormatter.string(from: date)
        
        birthdayField.text = dateString
        
        user.birthday = date
        userManager.change(user: user)
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
extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}


