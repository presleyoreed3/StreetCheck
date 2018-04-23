//
//  GroupsTableViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 3/25/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit
import os.log

enum groupSearchSelectedScope:Int{
    case name = 0
    case members = 1
    case leader = 2
    case crime = 3
    case address = 4
}

class GroupsTableViewController: UITableViewController, UISearchBarDelegate  {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Properties
    var groups = [Group]()
    var constantGroups = [Group]()
    var currentGroup: Group?
    
    var celleIdentifier = "groupCellNarrow"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSearchBar()
        if (celleIdentifier == "groupCellNarrow"){
            
        }else {
            self.tableView.rowHeight = 375
        }
        self.tableView.rowHeight = 120
        navigationItem.leftBarButtonItem = editButtonItem
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
    
    //MARK: Cell Layout
    @IBAction func swapLayouts(_ sender: UIBarButtonItem){
        if (celleIdentifier == "groupCellNarrow"){
            celleIdentifier = "groupCellWide"
        }else {
            celleIdentifier = "groupCellNarrow"
        }
        tableView.reloadData()
    }
    
    func loadCellView() -> String{
        if (celleIdentifier == "groupCellNarrow"){
            self.tableView.rowHeight = 120.0
            return "groupCellNarrow"
        }else {
            self.tableView.rowHeight = 375
            return "groupCellWide"
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        celleIdentifier = loadCellView()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: celleIdentifier, for: indexPath) as? GroupsTableViewCell else{
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showGroupDetails", sender: self)
        currentGroup = groups[(tableView.indexPathForSelectedRow?.row)!]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? GroupViewController
        destination?.groupOnDisplay = groups[(tableView.indexPathForSelectedRow?.row)!]
        
    }
    
    private func setUpSearchBar(){
        let searchBar = UISearchBar(frame: CGRect(x:0, y:0,width:(UIScreen.main.bounds.width),height: 70))
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Name", "Members", "Leader", "Crime", "Address"]
        searchBar.selectedScopeButtonIndex = 0
        self.tableView.tableHeaderView = searchBar
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            groups = constantGroups
            self.tableView.reloadData()
        }
        else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex, text: searchText)
        }
    }
    
    private func filterTableView(ind:Int, text: String){
        switch ind {
        case groupSearchSelectedScope.name.rawValue:
            groups = groups.filter({ group -> Bool in return (group.name?.contains(text))!})
            self.tableView.reloadData()
        case groupSearchSelectedScope.members.rawValue:
            print("Search Scope: \(groupSearchSelectedScope.members.rawValue) ")
            groups = groups.filter({ group -> Bool in return (group.members?.contains(text))!})
            self.tableView.reloadData()
        case searchSelectedScope.sex.rawValue:
            print("Search Scope: \(searchSelectedScope.sex.rawValue) ")
            groups = groups.filter({ group -> Bool in return (group.leader?.contains(text))!})
            self.tableView.reloadData()
        case searchSelectedScope.crime.rawValue:
            print("Search Scope: \(searchSelectedScope.crime.rawValue) ")
            groups = groups.filter({ group -> Bool in return (group.crimes?.contains(text))!})
            self.tableView.reloadData()
        case searchSelectedScope.address.rawValue:
            print("Search Scope: \(searchSelectedScope.address.rawValue) ")
            groups = groups.filter({ group -> Bool in return (group.location?.contains(text))!})
            self.tableView.reloadData()
        default:
            print("No Type")
        }
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
        var checkingGroups = NSKeyedUnarchiver.unarchiveObject(withFile: Group.ArchiveURL.path) as? [Group]
        for group in checkingGroups!{
            let index = checkingGroups?.index(of: group)
            let timeLastModified = group.dateAndTime
            let fiveYearsInSeconds = TimeInterval(31536000 * 5)
            let timeToExpire = timeLastModified! + fiveYearsInSeconds
            let currentDateandTime = Date()
            if (timeToExpire<currentDateandTime){
                checkingGroups?.remove(at: index!)
            }
        }
        return checkingGroups
    }


}
