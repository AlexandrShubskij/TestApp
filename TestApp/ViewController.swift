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
    
    
    
    var autoNames = [String]()
    let identifire = "autoNamesCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editButton.title = "Edit"
        for autos in AutosInfo.autoInfo.keys {
            autoNames.append(autos)
        }
        autoNames.sort()
//        print(AutosInfo.autoInfo["BMW X6"]!["Body"] as Any)
    }

    //MARK: edit button action
    @IBAction func editButtonAction(_ sender: Any) {
        if autoTableView.isEditing == false {
            editButton.title = "Done"
        } else {
            editButton.title = "Edit"
        }
        autoTableView.isEditing = !autoTableView.isEditing
    }
    
    //MARK: add button action
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = autoTableView.indexPathForSelectedRow {
            let dvc = segue.destination as! InfoViewController
            dvc.autoName = self.autoNames[indexPath.row]
        }
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
    
    //MARK: copy cells info
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) {
            return true
        }
        return false
    }
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        if action == #selector(copy(_:)) {
            let cell = tableView.cellForRow(at: indexPath)
            let pasteBoard = UIPasteboard.general
            pasteBoard.string = cell?.textLabel?.text
        }
    }
    
}

