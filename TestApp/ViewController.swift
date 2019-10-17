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
    
    
    
    var autosNames = [String]()
    var autoNames = [String]()
    let identifire = "autoNamesCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editButton.title = "Edit"
        makeArray()
        self.title = "Автомобили"
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        makeArray()
        self.autoTableView.reloadData()
    }
    
    func  makeArray() {
        autosNames.removeAll()
        for autos in AutosInfo.autoInfo.keys {
            autosNames.append(autos)
        }
        autoNames = Array(Set(autosNames))
        autoNames.sort()
    }
    
    //MARK: edit button action
    @IBAction func editButtonAction(_ sender: Any) {
        if autoTableView.isEditing == false {
            editButton.title = "Save"
        } else {
            editButton.title = "Edit"
        }
        autoTableView.isEditing = !autoTableView.isEditing
    }
    
    //MARK: add button action
    
    
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
    
    //MARK: prepare fo segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? InfoViewController else {return}
        if let indexPath = autoTableView.indexPathForSelectedRow {
                dvc.autoName = self.autoNames[indexPath.row]

        }
    }
    
    //MARK: delete cells
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showDeleteWarning(for: indexPath)
            
            
            
            
            
        }
    }
    func showDeleteWarning(for indexPath: IndexPath) {
        let alert = UIAlertController(title: "Предупреждение!", message: "Вы действительно хотите удалить автомобиль?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Да", style: .destructive) { _ in
            DispatchQueue.main.async {
                AutosInfo.autoInfo[self.autoNames[indexPath.row]] = nil
                self.autoNames.remove(at: indexPath.row)
                self.autoTableView.deleteRows(at: [indexPath], with: .left)
            }
        }
        
        //Add the actions to the alert controller
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        //Present the alert controller
        present(alert, animated: true, completion: nil)
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
    
    //MARK: copy auto name in cells
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

