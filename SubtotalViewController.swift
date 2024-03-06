//
//  SubtotalViewController.swift
//  BillSplit
//
//  Created by iMac on 06/05/2023.
//  Copyright © 2023 Garnaga. All rights reserved.
//

import UIKit



class SubtotalViewController: UIViewController {

    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var subtotalLabel: UILabel!
    @IBOutlet var nextToTaxButton: UIButton!
    @IBOutlet var splitEquallyButton: UIButton!
    @IBOutlet var splitByItemsButton: UIButton!
    @IBOutlet var subtotalStackView: UIStackView!
    @IBOutlet var taxStackView: UIStackView!
    @IBOutlet var taxLabel: UILabel!
    @IBOutlet var taxNumberButtons: [UIButton]!
    
    var people: Int!
    var sharers = [Person]()
    
    // creating People structs to manage participants and shares
    func createPeople() {
        for i in 0 ..< people {
            let sharer = Person(name: "person \(i+1)", share: 0.00)
            sharers.append(sharer)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taxStackView.isHidden = true
        createPeople()
    }
    
    // user entry logic
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        let number = sender.title(for: .normal)!
        subtotalLabel.text?.append(number)
        
        // handling empty value before dot
        if number.contains(".") {
            if subtotalLabel.text == "." {
                subtotalLabel.text?.removeLast()
                subtotalLabel.text?.append("0.")
            }
        }
        
        // allowing only 2 chars after a dot
        if (subtotalLabel.text?.contains("."))! {
            
            var splitText = subtotalLabel.text?.components(separatedBy: ".")
            let totalDots = (splitText?.count)! - 1
            let decimalDigits = 2
            
            
            splitText?.removeFirst()
            
            if
                (splitText?.last?.count ?? 0) > decimalDigits
            {
                subtotalLabel.text?.removeLast()
            }
            
            if totalDots > 1 {
                subtotalLabel.text?.removeLast()
            }
        }
        
        // handling too many digits
        if (subtotalLabel.text?.count)! > 6 {
            disableNumberButtons()
        }

    }
    
    // "C" button handling aka erase
    @IBAction func eraseNumberPressed(_ sender: Any) {
        if subtotalLabel.text == "" {
            return
        } else {
        subtotalLabel.text?.removeLast()
        enableNumberButtons()
        }
    }
    
    // disabling in case too many digits
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
    
    // changing scene to tax with next button
    @IBAction func nextToTaxButtonPressed(_ sender: Any) {
        if subtotalLabel.text == "" {
            return
        } else {
        subtotalStackView.isHidden = true
        taxStackView.isHidden = false
        }
    }
    
    // user tax entry logic
    @IBAction func taxNumberButtonPressed(_ sender: UIButton) {
        let number = sender.title(for: .normal)!
        taxLabel.text?.append(number)
        
        // handling empty value before dot
        if number.contains(".") {
            if taxLabel.text == "." {
                taxLabel.text?.removeLast()
                taxLabel.text?.append("0.")
            }
        }
        
        // allowing only 2 chars after a dot
        if (taxLabel.text?.contains("."))! {
            
            var splitText = taxLabel.text?.components(separatedBy: ".")
            let totalDots = (splitText?.count)! - 1
            let decimalDigits = 2
            
            
            splitText?.removeFirst()
            
            if
                (splitText?.last?.count ?? 0) > decimalDigits
            {
                taxLabel.text?.removeLast()
            }
            
            if totalDots > 1 {
                taxLabel.text?.removeLast()
            }
        }
        
        // handling too many digits
        if (taxLabel.text?.count)! > 6 {
            disableTaxNumberButtons()
        }

    }
    
    @IBAction func eraseTaxNumberPressed(_ sender: Any) {
        if taxLabel.text == "" {
            return
        } else {
        taxLabel.text?.removeLast()
        enableTaxNumberButtons()
        }
    }
    
    
    func disableTaxNumberButtons() {
        for button in taxNumberButtons {
            button.isEnabled = false
        }
    }
    
    func enableTaxNumberButtons() {
        for button in taxNumberButtons {
            button.isEnabled = true
        }
    }
    
       // split subtotal+tax between sharers equally if "Split equally" pressed, push to results
    @IBAction func splitEquallyButtonPressed(_ sender: Any) {

        let subtotal = Double(subtotalLabel.text!)
        let tax = Double(taxLabel.text!) ?? 0.0
        let total = subtotal! + tax
        let share = total / Double(people)
        sharers = sharers.map{
            var mutableSharer = $0
            mutableSharer.increment(by: share)
            return mutableSharer
            }
        performSegue(withIdentifier: "Results", sender: nil)
        }
    
    // preparing data for passing to Items and Results controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Items" {
            let ItemsViewController = segue.destination as! ItemsViewController
            ItemsViewController.people = people
            ItemsViewController.sharers = sharers
            ItemsViewController.subtotal = Double(subtotalLabel.text!)
            ItemsViewController.tax = Double(taxLabel.text!) ?? 0.0
        }
        
        if segue.identifier == "Results" {
            let ResultsViewController = segue.destination as! ResultsViewController
            ResultsViewController.people = people
            ResultsViewController.sharers = sharers
            ResultsViewController.subtotal = Double(subtotalLabel.text!)
            ResultsViewController.tax = Double(taxLabel.text!) ?? 0.0
        }

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


