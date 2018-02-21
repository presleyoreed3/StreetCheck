//
//  ContactTableViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 2/11/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {
    
    //MARK: Properties
    var contacts = [Contact]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadContacts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ContactTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContactTableViewCell else{
            fatalError("The dequeued cell is not an instance of ContactTableViewCell.")
        }
        
        let contact = contacts[indexPath.row]
        //let full_name = contact.first_name 
        cell.firstNameLabel.text = contact.first_name
        cell.lastNameLabel.text = contact.last_name
        cell.ageLabel.text = contact.birthday
        cell.heightLabel.text = contact.height
        cell.weightLabel.text = contact.weight
        cell.photoCell.image = contact.photo
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? ContactViewController
        destination?.contactOnDisplay = contacts[(tableView.indexPathForSelectedRow?.row)!]
    }
    
    //MARK: Privte Methods
    private func loadContacts(){
        let contact1 = Contact(first_name: "Presley", middle_name: "Orelle", last_name: "Reed III", alias: "Presso", birthday: "December 18, 1995", MO: "None", height: "6.2", weight: "230", hair_color: "Brown", eye_color: "Brown", sex: "Male", address: nil, time_left: nil, photo: nil)
        let contact2 = Contact(first_name: "Meredith", middle_name: "Demming", last_name: "Reed", alias: "Mer", birthday: "March 8, 1991", MO: "None", height: "5.6", weight: "100", hair_color: "Brown", eye_color: "Hazel", sex: "Female", address: nil, time_left: nil, photo: UIImage(named: "Default Contact Image"))
        contacts += [contact1, contact2]
    }
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController, let contact = sourceViewController.contact {
            //Adds a new contact
            let newIndexPath = IndexPath(row: contacts.count, section: 0)
            
            contacts.append(contact)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
}
