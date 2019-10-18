//
//  InfoViewController.swift
//  TestApp
//
//  Created by Александр Шубский on 15.10.2019.
//  Copyright © 2019 Александр Шубский. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var manufacturerTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    @IBOutlet weak var editInfoButton: UIBarButtonItem!

    @IBOutlet weak var manufacturerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var yearTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bodyTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var manufacturerStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var yearStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var colorStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bodyStackViewHeight: NSLayoutConstraint!
    
    
    
    var autoName: String?
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShows(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHides(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        super.viewDidLoad()
        editInfoButton.title = "Edit"
        infoViewNoEdit()
        self.title = autoName
    }
    
    
    //MARK: Edit/no edit interface
    func infoViewNoEdit() {
        manufacturerTextField.text = (AutosInfo.autoInfo["\(autoName!)"]!["Manufacturer"] as Any as! String)
        yearTextField.text = (AutosInfo.autoInfo["\(autoName!)"]!["Year"] as Any as! String)
        colorTextField.text = (AutosInfo.autoInfo["\(autoName!)"]!["Color"] as Any as! String)
        bodyTextField.text = (AutosInfo.autoInfo["\(autoName!)"]!["Body"] as Any as! String)
        manufacturerTextField.isEnabled = false
        yearTextField.isEnabled = false
        colorTextField.isEnabled = false
        bodyTextField.isEnabled = false
        manufacturerTextField.borderStyle = .none
        yearTextField.borderStyle = .none
        colorTextField.borderStyle = .none
        bodyTextField.borderStyle = .none
    }
    
    //MARK: Check and save changes in dictionary
    func saveChanges() {
        if manufacturerTextField.text?.isEmpty == true {
            AutosInfo.autoInfo["\(autoName!)"]!["Manufacturer"] = "Не указано"
        } else {
            AutosInfo.autoInfo["\(autoName!)"]!["Manufacturer"] = manufacturerTextField.text
        }
        if yearTextField.text?.isEmpty == true {
            AutosInfo.autoInfo["\(autoName!)"]!["Year"] = "Не указано"
        } else {
            AutosInfo.autoInfo["\(autoName!)"]!["Year"] = yearTextField.text
        }
        if colorTextField.text?.isEmpty == true {
            AutosInfo.autoInfo["\(autoName!)"]!["Color"] = "Не указано"
        } else {
            AutosInfo.autoInfo["\(autoName!)"]!["Color"] = colorTextField.text
        }
        if bodyTextField.text?.isEmpty == true {
            AutosInfo.autoInfo["\(autoName!)"]!["Body"] = "Не указано"
        } else {
            AutosInfo.autoInfo["\(autoName!)"]!["Body"] = bodyTextField.text
        }
    }
    
    //MARK: Up content above keyboard
    @objc func keyboardWillShows(notification: Notification) {
        let viewWithoutStatusBarAndNavigationBar = self.view.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.size.height
        let manufacturerBottomConstraint  = viewWithoutStatusBarAndNavigationBar - manufacturerTopConstraint.constant - manufacturerStackViewHeight.constant
        let yearBottomConstraint = viewWithoutStatusBarAndNavigationBar - yearTopConstraint.constant - yearStackViewHeight.constant
        let colorBottomConstrain = viewWithoutStatusBarAndNavigationBar - colorTopConstraint.constant - colorStackViewHeight.constant
        let bodyBottomConstraint = viewWithoutStatusBarAndNavigationBar - bodyTopConstraint.constant - bodyStackViewHeight.constant
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
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
    
    //MARK: Edit button action
    @IBAction func editInfoButtonAction(_ sender: Any) {
        manufacturerTextField.isEnabled = !manufacturerTextField.isEnabled
        yearTextField.isEnabled = !yearTextField.isEnabled
        colorTextField.isEnabled = !colorTextField.isEnabled
        bodyTextField.isEnabled = !bodyTextField.isEnabled
        if manufacturerTextField.isEnabled == true {
            editInfoButton.title = "Save"
            manufacturerTextField.borderStyle = .roundedRect
            yearTextField.borderStyle = .roundedRect
            colorTextField.borderStyle = .roundedRect
            bodyTextField.borderStyle = .roundedRect
            saveChanges()
            
        } else {
            editInfoButton.title = "Edit"
            saveChanges()
            infoViewNoEdit()
            UserDefaults.standard.removeObject(forKey: "Autos")
            UserDefaults.standard.setValue(AutosInfo.autoInfo, forKey: "Autos")
        }
        
    }
    
    // Up/down keyboard with touch inside the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
