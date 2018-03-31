//
//  GroupsTableViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 3/25/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit
import os.log

class GroupsTableViewController: UITableViewController {
    
    //MARK: Properties
    var groups = [Group]()
    var constantGroups = [Group]()
    var currentGroup: Group?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = 120
        if let savedGroups = loadGroups() {
            groups += savedGroups
        }
    }
    
    //MARK: Table View Data
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            groups.remove(at: indexPath.row)
            saveGroup()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupsTableViewCell else{
            fatalError("The dequeued cell is not an instance of ContactTableViewCell.")
        }
        
        let group = groups[indexPath.row]
        cell.groupNameLabel.text = group.name
        cell.groupLeaderLabel.text = group.leader
        cell.groupImageLabel.image = group.image
        cell.groupLocationLabel.text = group.location
        
        cell.groupImageLabel.contentMode = .scaleAspectFill
        cell.groupImageLabel.clipsToBounds = true
        
        print(group)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? GroupViewController
        destination?.groupOnDisplay = groups[(tableView.indexPathForSelectedRow?.row)!]
        
    }
    
    //MARK: Unwinding
    @IBAction func unwindToGroupAdd(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddGroupViewController, let group = sourceViewController.group {
            //Adds a new contact
            let newIndexPath = IndexPath(row: constantGroups.count, section: 0)

            groups.append(group)
            constantGroups.append(group)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            currentGroup = group
            saveGroup()
            tableView.reloadData()
        }
    }
    
    @IBAction func unwindToGroupTableView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? GroupViewController, let group = sourceViewController.groupOnDisplay {
            
            groups[(tableView.indexPathForSelectedRow?.row)!] = group
            constantGroups = groups
            saveGroup()
            tableView.reloadData()
        }
    }
    
    private func saveGroup(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(groups, toFile: Group.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Groups successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save groups...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadGroups() -> [Group]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Group.ArchiveURL.path) as? [Group]
    }


}
