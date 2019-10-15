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
        super.viewDidLoad()
        self.title = "Добавление автомобиля"
    }
    
        
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        check()
        endWriting()
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
