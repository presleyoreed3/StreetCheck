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
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
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
