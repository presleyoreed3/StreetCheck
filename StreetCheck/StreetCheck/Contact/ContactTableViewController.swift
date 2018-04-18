//
//  ContactTableViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 2/11/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit
import os.log

enum searchSelectedScope:Int{
    case name = 0
    case ethnicity = 1
    case sex = 2
    case crime = 3
    case address = 4
    
}

class ContactTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: Properties
    var contacts = [Contact]()
    var constantContacts = [Contact]()
    var currentContact: Contact?
    var currentContactArray = [Contact]()
    var cellIdentifier = "NarrowContactTableViewCell"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSearchBar()
        if (cellIdentifier == "NarrowContactTableViewCell"){
            
        }else{
            self.tableView.rowHeight = 340.0
        }
        navigationItem.leftBarButtonItem = editButtonItem
        if let savedContacts = loadContacts() {
            contacts += savedContacts
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            contacts.remove(at: indexPath.row)
            saveContact()
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
    
    
    //MARK: Cell Layout
    @IBAction func swapLayouts(_ sender: UIBarButtonItem) {
        if (cellIdentifier == "NarrowContactTableViewCell"){
            cellIdentifier = "WideContactTableViewCell"
        }else{
            cellIdentifier = "NarrowContactTableViewCell"
        }
        tableView.reloadData()
    }
    
    func loadCellView() -> String{
        if (cellIdentifier == "NarrowContactTableViewCell"){
            self.tableView.rowHeight = 90.0
            return "NarrowContactTableViewCell"
        }else{
            self.tableView.rowHeight = 340.0
            return "WideContactTableViewCell"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellIdentifier = loadCellView()

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContactTableViewCell else{
            fatalError("The dequeued cell is not an instance of ContactTableViewCell.")
        }
        
        let contact = contacts[indexPath.row]
        //let full_name = contact.first_name 
        cell.firstNameLabel.text = contact.first_name
        cell.lastNameLabel.text = contact.last_name
        cell.photoCell.image = contact.photo
        cell.ageLabel.text = contact.birthday
        cell.heightLabel.text = contact.height
        cell.weightLabel.text = contact.weight
        
        cell.photoCell.contentMode = .scaleAspectFill
        cell.photoCell.clipsToBounds = true
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
        currentContact = contacts[(tableView.indexPathForSelectedRow?.row)!]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? ContactViewController
        destination?.contactOnDisplay = contacts[(tableView.indexPathForSelectedRow?.row)!]
        
    }
    
    //MARK: Search Bar

    private func setUpSearchBar(){
        let searchBar = UISearchBar(frame: CGRect(x:0, y:0,width:(UIScreen.main.bounds.width),height: 70))
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Name", "Ethnicity", "Sex", "Crime", "Address"]
        searchBar.selectedScopeButtonIndex = 0
        self.tableView.tableHeaderView = searchBar
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            contacts = constantContacts
            self.tableView.reloadData()
        }
        else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex, text: searchText)
        }
    }
    
    private func filterTableView(ind:Int, text: String){
        switch ind {
        case searchSelectedScope.name.rawValue:
            contacts = contacts.filter({ contact -> Bool in return contact.first_name.contains(text) || contact.last_name.contains(text) || (contact.middle_name?.contains(text))! || (contact.alias?.contains(text))!})
            self.tableView.reloadData()
        case searchSelectedScope.ethnicity.rawValue:
            print("Search Scope: \(searchSelectedScope.ethnicity.rawValue) ")
            contacts = contacts.filter({ contact -> Bool in return (contact.ethnicity?.contains(text))!})
            self.tableView.reloadData()
        case searchSelectedScope.sex.rawValue:
            print("Search Scope: \(searchSelectedScope.sex.rawValue) ")
            contacts = contacts.filter({ contact -> Bool in return (contact.sex?.contains(text))!})
            self.tableView.reloadData()
        case searchSelectedScope.crime.rawValue:
            print("Search Scope: \(searchSelectedScope.crime.rawValue) ")
            contacts = contacts.filter({ contact -> Bool in return (contact.crime?.contains(text))!})
            self.tableView.reloadData()
        case searchSelectedScope.address.rawValue:
            print("Search Scope: \(searchSelectedScope.address.rawValue) ")
            contacts = contacts.filter({ contact -> Bool in return (contact.address?.contains(text))!})
            self.tableView.reloadData()
        default:
            print("No Type")
        }
    }
    
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController, let contact = sourceViewController.contact {
            //Adds a new contact
            let newIndexPath = IndexPath(row: currentContactArray.count, section: 0)
            contacts.append(contact)
            constantContacts.append(contact)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            saveContact()
            tableView.reloadData()
        }
    }
    
    @IBAction func unwindToTableView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ContactViewController, let contact = sourceViewController.contactOnDisplay {
            contacts[(tableView.indexPathForSelectedRow?.row)!] = contact
            if (CONTACT_EDIT_WAS_PRESSED == true){
                constantContacts = contacts
                saveContact()
            }
            tableView.reloadData()
        }
    }
    
    //MARK: Private Methods
    private func saveContact(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(contacts, toFile: Contact.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Contacts successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save contacts...", log: OSLog.default, type: .error)
        }
    }

    private func loadContacts() -> [Contact]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Contact.ArchiveURL.path) as? [Contact]
    }
    
}
