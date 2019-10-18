//
//  AddNewViewController.swift
//  TestApp
//
//  Created by Александр Шубский on 15.10.2019.
//  Copyright © 2019 Александр Шубский. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var manufacturerTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    @IBOutlet weak var modelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var manufacturerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var yearTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bodyTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var modelStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var manufacturerStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var yearStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var colorStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bodyStackViewHeight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var model: String?
    var manufacturer: String?
    var year: String?
    var color: String?
    var body: String?
    
    func check() {
        if (modelTextField.text?.isEmpty == true) || (modelTextField.text == nil) {
            model = "Неизвестно"
        } else {
            model = modelTextField.text!
        }
        if (manufacturerTextField.text?.isEmpty == true) || (manufacturerTextField.text == nil) {
            manufacturer = "Не указано"
        } else {
            manufacturer = manufacturerTextField.text!
        }
        if (yearTextField.text?.isEmpty == true) || (yearTextField.text == nil) {
            year = "Не указано"
        } else {
            year = yearTextField.text!
        }
        if (colorTextField.text?.isEmpty == true) || (colorTextField.text == nil) {
            color = "Не указано"
        } else {
            color = colorTextField.text!
        }
        if (bodyTextField.text?.isEmpty == true) || (bodyTextField.text == nil) {
            body = "Не указано"
        } else {
            body = bodyTextField.text!
        }
        AutosInfo.autoInfo["\(model!)"] = ["Manufacturer": "\(manufacturer!)", "Year": "\(year!)", "Color": "\(color!)", "Body": "\(body!)"]
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShows(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHides(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        super.viewDidLoad()
        self.title = "Добавление автомобиля"
        saveButton.title = "Save"
    }
    
        
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        check()
        endWriting()
        UserDefaults.standard.removeObject(forKey: "Autos")
        UserDefaults.standard.setValue(AutosInfo.autoInfo, forKey: "Autos")
    }
    
    func endWriting() {
        modelTextField.isEnabled = !modelTextField.isEnabled
        manufacturerTextField.isEnabled = !manufacturerTextField.isEnabled
        yearTextField.isEnabled = !yearTextField.isEnabled
        colorTextField.isEnabled = !colorTextField.isEnabled
        bodyTextField.isEnabled = !bodyTextField.isEnabled
        if manufacturerTextField.isEnabled == true {
            saveButton.title = "Save"
            modelTextField.borderStyle = .roundedRect
            manufacturerTextField.borderStyle = .roundedRect
            yearTextField.borderStyle = .roundedRect
            colorTextField.borderStyle = .roundedRect
            bodyTextField.borderStyle = .roundedRect
        } else {
            saveButton.title = "Edit"
            modelTextField.borderStyle = .none
            manufacturerTextField.borderStyle = .none
            yearTextField.borderStyle = .none
            colorTextField.borderStyle = .none
            bodyTextField.borderStyle = .none
        }
    }
    
    @objc func keyboardWillShows(notification: Notification) {
        let viewWithoutStatusBarAndNavigationBar = self.view.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.size.height
        let modelBottomConstraint  = viewWithoutStatusBarAndNavigationBar - modelTopConstraint.constant - modelStackViewHeight.constant
        let manufacturerBottomConstraint  = viewWithoutStatusBarAndNavigationBar - manufacturerTopConstraint.constant - manufacturerStackViewHeight.constant
        let yearBottomConstraint = viewWithoutStatusBarAndNavigationBar - yearTopConstraint.constant - yearStackViewHeight.constant
        let colorBottomConstrain = viewWithoutStatusBarAndNavigationBar - colorTopConstraint.constant - colorStackViewHeight.constant
        let bodyBottomConstraint = viewWithoutStatusBarAndNavigationBar - bodyTopConstraint.constant - bodyStackViewHeight.constant
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                if modelTextField.isEditing ==  true {
                    if modelBottomConstraint < keyboardSize.height {
                        self.view.frame.origin.y -= (keyboardSize.height - modelBottomConstraint)
                    }
                }
                if manufacturerTextField.isEditing ==  true {
                    if manufacturerBottomConstraint < keyboardSize.height {
                        self.view.frame.origin.y -= (keyboardSize.height - manufacturerBottomConstraint)
                    }
                }
                if yearTextField.isEditing == true {
                    if yearBottomConstraint < keyboardSize.height {
                        self.view.frame.origin.y -= (keyboardSize.height - yearBottomConstraint)
                    }
                }
                if colorTextField.isEditing == true {
                    if  colorBottomConstrain < keyboardSize.height {
                        self.view.frame.origin.y -= (keyboardSize.height - colorBottomConstrain)
                    }
                }
                if bodyTextField.isEditing ==  true {
                    if  bodyBottomConstraint < keyboardSize.height {
                        self.view.frame.origin.y -= (keyboardSize.height - bodyBottomConstraint)
                    }
                }
            }
        }
    }
    
    @objc func keyboardWillHides(notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
