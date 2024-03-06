//
//  PeopleViewController.swift
//  BillSplit
//
//  Created by iMac on 23/05/2023.
//  Copyright © 2023 Garnaga. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {

    var people: Int!
    @IBOutlet weak var peopleTableView: UITableView!
    
    
    var participants = ["person 1", "person 2", "person 3", "person 4", "person 5", "person 6", "person 7", "person 8", "person 9", "person 10"]
    
    var selectedParticipants: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // going back to Items with selected participants
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToItems" {
            let ItemsViewController = segue.destination as! ItemsViewController
            ItemsViewController.selectedParticipants = selectedParticipants
        }
    }

}
// managing the table view
extension PeopleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people
    }
    
    // populates rows with options
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let number = participants[indexPath.row]
        cell.textLabel?.text = number
        
        let selectedIndexPaths = tableView.indexPathsForSelectedRows
        let rowIsSelected = selectedIndexPaths != nil && selectedIndexPaths!.contains(indexPath)
        cell.accessoryType = rowIsSelected ? .checkmark : .none
        
        return cell
    }
    
    // appending selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .checkmark
        
        selectedParticipants.append((cell.textLabel?.text)!)
    }
    

    // removing unselected
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .none
        let optionToRemove = cell.textLabel?.text
        if let index = selectedParticipants.firstIndex(of: optionToRemove!) {
            selectedParticipants.remove(at: index)
        }
    }
    
}

