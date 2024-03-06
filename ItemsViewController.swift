//
//  ItemsViewController.swift
//  BillSplit
//
//  Created by iMac on 06/05/2023.
//  Copyright © 2023 Garnaga. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var remainingSumLabel: UILabel!
    @IBOutlet var nextItemButton: UIButton!
    @IBOutlet var chosenPartyLabel: UILabel!
    
    
    var people: Int!
    var subtotal: Double!
    var tax: Double!
    var selectedParticipants: [String]!
    var remainder: Double!
    var sharers = [Person]()
    
    // unwind to Items after choosing party in PeopleView and display party in a label
    @IBAction func unwindToItems(unwindSegue: UIStoryboardSegue) {
        chosenPartyLabel.text = "Chosen: \(selectedParticipants.joined(separator: ", "))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        remainder = subtotal
        updateUI()
    }
    
    // showing remaining sum and pushing to results if 0
    func updateUI() {
        remainingSumLabel.text = "\(String(format: "%.2f", remainder ?? 0.00)) remaining"
        if remainder == 0 {
            performSegue(withIdentifier: "pushResults", sender: Any?.self)
        }
    }
    
    // user item entry logic
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        let number = sender.title(for: .normal)!
        itemLabel.text?.append(number)
        
        // handling empty value before dot
        if number.contains(".") {
            if itemLabel.text == "." {
                itemLabel.text?.removeLast()
                itemLabel.text?.append("0.")
            }
        }
        
        // allowing only 2 chars after a dot
        if (itemLabel.text?.contains("."))! {
            
            var splitText = itemLabel.text?.components(separatedBy: ".")
            let totalDots = (splitText?.count)! - 1
            let decimalDigits = 2
            
            
            splitText?.removeFirst()
            
            if
                (splitText?.last?.count ?? 0) > decimalDigits
            {
                itemLabel.text?.removeLast()
            }
            
            if totalDots > 1 {
                itemLabel.text?.removeLast()
            }
        }
        
        // handling too many digits
        if (itemLabel.text?.count)! > 6 {
            disableNumberButtons()
        }
    }
    
    @IBAction func eraseButtonPressed(_ sender: Any) {
        if itemLabel.text == "" {
            return
        } else {
            itemLabel.text?.removeLast()
            enableNumberButtons()
        }
    }
    
    func disableNumberButtons() {
        for button in numberButtons {
            button.isEnabled = false
        }
    }
    
    func enableNumberButtons() {
        for button in numberButtons {
            button.isEnabled = true
        }
    }
    
    // saving item, updating remainder, showing a warning if item price is greater than the remaining sum, updating shares
    @IBAction func nextItemButtonPressed(_ sender: Any) {
        
        if chosenPartyLabel.text == "" {
            return
        }
        
        let itemPrice = Double(itemLabel.text!) ?? 0
        
        if itemPrice != 0 {
            let oldRemainder = remainder
            remainder = oldRemainder! - itemPrice
            

            itemLabel.text = ""
            

            if remainder < 0 {
                remainder = oldRemainder
                let alert = UIAlertController(title: "Aw-shucks!", message: "Item price is greater than the subtotal remainder.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            //updating shares of selected parties
            let pricePerPerson = itemPrice / Double(selectedParticipants.count)
            for i in selectedParticipants {
                sharers = sharers.map{
                    var mutableSharer = $0
                    if $0.name == i {
                        mutableSharer.increment(by: pricePerPerson)
                    }
                    return mutableSharer
                }
            }
            
            updateUI()
        }
    }
    
    // splits remainder+tax between sharers in shares (adds to existing shares) and pushes to Results
    @IBAction func splitRestButtonPressed(_ sender: Any) {

        let allRemainingShares = remainder + tax
        let share = allRemainingShares / Double(people)
        sharers = sharers.map{
            var mutableSharer = $0
            mutableSharer.increment(by: share)
            return mutableSharer
        }
        
        performSegue(withIdentifier: "splitRest", sender: nil)
    }
    
    // data passing to Results and People
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushResults" {
            let ResultsViewController = segue.destination as! ResultsViewController
            ResultsViewController.people = people
            ResultsViewController.sharers = sharers
            ResultsViewController.subtotal = subtotal
            ResultsViewController.tax = tax
        }
        
        if segue.identifier == "splitRest" {
            let ResultsViewController = segue.destination as! ResultsViewController
            ResultsViewController.people = people
            ResultsViewController.sharers = sharers
            ResultsViewController.subtotal = subtotal
            ResultsViewController.tax = tax
        }
        
        if segue.identifier == "People" {
            let PeopleViewController = segue.destination as! PeopleViewController
            PeopleViewController.people = people
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
