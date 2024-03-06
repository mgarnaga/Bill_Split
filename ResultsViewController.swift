//
//  ResultsViewController.swift
//  BillSplit
//
//  Created by iMac on 06/05/2023.
//  Copyright © 2023 Garnaga. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet var subtotalLabel: UILabel!
    @IBOutlet var taxLabel: UILabel!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
    @IBOutlet var tipSlider: UISlider!
    

    @IBOutlet var shareLabels: [UILabel]!
    @IBOutlet var personStacks: [UIStackView]!
    
    
    var people: Int!
    var subtotal: Double!
    var tax: Double!
    var tip: Double = 0.00
    var defaultTip: Double = 0.00
    var sharers = [Person]()
    
    // updating to custom tip from Tip View Controller
    @IBAction func unwindToResults(unwindSegue: UIStoryboardSegue) {
        tipLabel.text = String(format: "%.2f", tip)
        updateUI()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideStacks()
        updateUI()
        navigationItem.hidesBackButton = true
        subtotalLabel.text = String(format: "%.2f", subtotal ?? 0.00)
        taxLabel.text = String(format: "%.2f", tax ?? 0.00)
        // Do any additional setup after loading the view.
    }
    
    // slider logic updates tip and saves old tip value
    @IBAction func tipSliderValueChanged(_ sender: UISlider) {
        let tipPercentage = round(tipSlider.value)
        defaultTip = tip
        tip = (subtotal / 100) * Double(tipPercentage)
        tipLabel.text = String(format: "%.2f", tip) + " (\(Int(tipPercentage))%)"
        updateUI()
    }
    
    func hideStacks() {
        for i in personStacks {
            i.isHidden = true
        }
    }
    
    // updates total label after tip change, presenting share labels in use, updates shares based on tip values
    func updateUI() {
        let total = subtotal + tax + tip
        totalLabel.text = String(format: "%.2f", total)
        
            for i in personStacks[0..<people] {
                    i.isHidden = false
            }
        
        sharers = sharers.map{
            var mutableSharer = $0
            if defaultTip < tip {
            mutableSharer.increment(by: ((tip - defaultTip) / Double(people)))
            return mutableSharer
            } else {
            mutableSharer.decrement(by: ((defaultTip - tip) / Double(people)))
            return mutableSharer
            }
        }
        
        // handling values of shares so that no cent is lost
        var shares = sharers.map { round($0.share*100) / 100.0 }
        let peopleTotal = shares.reduce(0, +)
        let remainder = total - peopleTotal
        shares[0] += remainder
        
        // presenting shares in according labels
        for (share, label) in zip(shares, shareLabels) {
            label.text = String(format: "%.2f", share)
        }
    }
    
    
}
