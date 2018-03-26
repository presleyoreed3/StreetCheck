//
//  ContactTableViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 2/11/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

enum searchSelectedScope:Int{
    case name = 0
    case ethnicity = 1
    case sex = 2
    case crime = 3
    case location = 4
    
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
        loadContacts()
        self.setUpSearchBar()
        if (cellIdentifier == "NarrowContactTableViewCell"){
            
        }else{
            self.tableView.rowHeight = 340.0
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    
    
    //MARK: Cell Layout
    @IBAction func swapLayouts(_ sender: UIBarButtonItem) {
        if (cellIdentifier == "NarrowContactTableViewCell"){
            cellIdentifier = "WideContactTableViewCell"
            print("I was switched to \(cellIdentifier)")
        }else{
            cellIdentifier = "NarrowContactTableViewCell"
            print("I was switched to \(cellIdentifier)")
        }
        tableView.reloadData()
    }
    
    func loadCellView() -> String{
        if (cellIdentifier == "NarrowContactTableViewCell"){
            print("I was switched to \(cellIdentifier)")
            self.tableView.rowHeight = 90.0
            return "NarrowContactTableViewCell"
        }else{
            print("I was switched to \(cellIdentifier)")
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
        if (cellIdentifier == "NarrowContactTableViewCell"){
            cell.ageLabel.text = contact.birthday
            cell.heightLabel.text = contact.height
            cell.weightLabel.text = contact.weight
        }
        
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
    
    //MARK: Privte Methods
    private func loadContacts(){
        let contact1 = Contact(first_name: "Presley", middle_name: "Orelle", last_name: "Reed III", alias: "Presso", birthday: "December 18, 1995", MO: "None", height: "6.2", weight: "230", hair_color: "Brown", eye_color: "Brown", sex: "Male", ethnicity: "White", dis_marks: "Scar on both eyebrows and bottom of the chin", address: "219 N. Tacoma Ave Tacoma, WA 98403", time_left: nil, photo: UIImage(named: "Default Contact Image"), crime: "Being too awesome")
        let contact2 = Contact(first_name: "Meredith", middle_name: "Demming", last_name: "Reed", alias: "Mer", birthday: "March 8, 1991", MO: "None", height: "5.6", weight: "100", hair_color: "Brown", eye_color: "Hazel", sex: "Female", ethnicity: "White", dis_marks: "None", address: "375 La Cienega Blvd, Los Angeles CA, 90048", time_left: nil, photo: UIImage(named: "Default Contact Image"), crime:"Being a great sister")
        let contact3 = Contact(first_name: "Presley", middle_name: "Orelle", last_name: "Reed III", alias: "Presso", birthday: "December 18, 1995", MO: "None", height: "6.2", weight: "230", hair_color: "Brown", eye_color: "Brown", sex: "Male", ethnicity: "White", dis_marks: "Scar on both eyebrows and bottom of the chin", address: "219 N. Tacoma Ave Tacoma, WA 98403", time_left: nil, photo: UIImage(named: "Default Contact Image"), crime: "Being too awesome")
        let contact4 = Contact(first_name: "Meredith", middle_name: "Demming", last_name: "Reed", alias: "Mer", birthday: "March 8, 1991", MO: "None", height: "5.6", weight: "100", hair_color: "Brown", eye_color: "Hazel", sex: "Female", ethnicity: "White", dis_marks: "None", address: "375 La Cienega Blvd, Los Angeles CA, 90048", time_left: nil, photo: UIImage(named: "Default Contact Image"), crime:"Being a great sister")
        contacts += [contact1, contact2, contact3, contact4]
        
        currentContactArray = contacts
        constantContacts = contacts
    }
    
    private func refresh(){
        self.tableView.reloadData()
    }
    
    //MARK: Search Bar

    private func setUpSearchBar(){
        let searchBar = UISearchBar(frame: CGRect(x:0, y:0,width:(UIScreen.main.bounds.width),height: 70))
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Name", "Ethnicity", "Sex", "Crime", "Location"]
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
            contacts = contacts.filter({ contact -> Bool in return contact.first_name.contains(text)})
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
        case searchSelectedScope.location.rawValue:
            print("Search Scope: \(searchSelectedScope.location.rawValue) ")
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
            currentContactArray = contacts
            tableView.reloadData()
        }
    }
    
    @IBAction func unwindToTableView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ContactViewController, let contact = sourceViewController.contactOnDisplay {
            
            contacts[(tableView.indexPathForSelectedRow?.row)!] = contact
            refresh()
            currentContactArray = contacts
            constantContacts = contacts
            tableView.reloadData()
        }
    }
    
}
