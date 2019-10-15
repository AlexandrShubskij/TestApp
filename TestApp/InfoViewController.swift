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
    
    var autoName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editInfoButton.title = "Edit"
        infoViewNoEdit()
        self.title = autoName
    }
    
    
    
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
    
    
    func saveChanges() {
        if manufacturerTextField.text?.isEmpty == true {
            AutosInfo.autoInfo["\(autoName!)"]!["Manufacturer"] = "Не указано"
        } else {
            AutosInfo.autoInfo["\(autoName!)"]!["Manufacturer"] = manufacturerTextField.text
        }
        guard yearTextField.text != nil else {
            AutosInfo.autoInfo["\(autoName!)"]!["Year"] = "Не указано"
            return
        }
        guard colorTextField.text != nil else {
            AutosInfo.autoInfo["\(autoName!)"]!["Color"] = "Не указано"
            return
        }
        guard bodyTextField.text != nil else {
            AutosInfo.autoInfo["\(autoName!)"]!["Body"] = "Не указано"
            return
        }
        
        AutosInfo.autoInfo["\(autoName!)"]!["Year"] = yearTextField.text
        AutosInfo.autoInfo["\(autoName!)"]!["Color"] = colorTextField.text
        AutosInfo.autoInfo["\(autoName!)"]!["Body"] = bodyTextField.text
    }
    
    
    @IBAction func editInfoButtonAction(_ sender: Any) {
        manufacturerTextField.isEnabled = !manufacturerTextField.isEnabled
        yearTextField.isEnabled = !yearTextField.isEnabled
        colorTextField.isEnabled = !colorTextField.isEnabled
        bodyTextField.isEnabled = !bodyTextField.isEnabled
        if manufacturerTextField.isEnabled == true {
            editInfoButton.title = "Done"
            manufacturerTextField.borderStyle = .roundedRect
            yearTextField.borderStyle = .roundedRect
            colorTextField.borderStyle = .roundedRect
            bodyTextField.borderStyle = .roundedRect
            saveChanges()
            
        } else {
            editInfoButton.title = "Edit"
            saveChanges()
            infoViewNoEdit()
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
