//
//  TipViewController.swift
//  BillSplit
//
//  Created by iMac on 06/05/2023.
//  Copyright © 2023 Garnaga. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var tipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    // user tip entry logic
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        let number = sender.title(for: .normal)!
        tipLabel.text?.append(number)
        
        // handling empty value before dot
        if number.contains(".") {
            if tipLabel.text == "." {
                tipLabel.text?.removeLast()
                tipLabel.text?.append("0.")
            }
        }
        
        // allowing only 2 chars after a dot
        if (tipLabel.text?.contains("."))! {
            
            var splitText = tipLabel.text?.components(separatedBy: ".")
            let totalDots = (splitText?.count)! - 1
            let decimalDigits = 2
            
            
            splitText?.removeFirst()
            
            if
                (splitText?.last?.count ?? 0) > decimalDigits
            {
                tipLabel.text?.removeLast()
            }
            
            if totalDots > 1 {
                tipLabel.text?.removeLast()
            }
        }
        
        // handling too many digits
        if (tipLabel.text?.count)! > 6 {
            disableNumberButtons()
        }
    }
    
    @IBAction func eraseButtonPressed(_ sender: Any) {
        if tipLabel.text == "" {
            return
        } else {
            tipLabel.text?.removeLast()
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
    
    // data passing (custom tip to Results)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToResults" {
            if tipLabel.text == "" {
                return
            } else {
            let ResultsViewController = segue.destination as! ResultsViewController
                ResultsViewController.tip = Double(tipLabel.text!) ?? 0.00
            }
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
