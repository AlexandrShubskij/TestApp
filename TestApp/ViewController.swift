//
//  ViewController.swift
//  TestApp
//
//  Created by Александр Шубский on 14.10.2019.
//  Copyright © 2019 Александр Шубский. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var autoTableView: UITableView!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var autoNames = ["Lada Kalina", "BMW X6", "Audi A8"]
    let identifire = "autoNamesCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editButton.title = "Edit"
    }

    
    @IBAction func editButtonAction(_ sender: Any) {
        if autoTableView.isEditing == false {
            editButton.title = "Done"
        } else {
            editButton.title = "Edit"
        }
        autoTableView.isEditing = !autoTableView.isEditing
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        cell.textLabel?.text = autoNames[indexPath.row ]
        
        return cell
    }
    
    
    //MARK: delete cells
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            autoNames.remove(at: indexPath.row)
            autoTableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    //MARK: move cells
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = autoNames[sourceIndexPath.row]
        autoNames.remove(at: sourceIndexPath.row)
        autoNames.insert(item, at: destinationIndexPath.row)
    }
    
}

