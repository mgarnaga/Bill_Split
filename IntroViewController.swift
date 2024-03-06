//
//  ViewController.swift
//  BillSplit
//
//  Created by iMac on 06/03/2023.
//  Copyright © 2023 Garnaga. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet var picker: UIPickerView!
    @IBOutlet var continueButton: UIButton!
    
    let options = ["2", "3", "4", "5", "6", "7", "8", "9", "10"]
    var selectedOption = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
    }
    
    // unwind when user starts over
    @IBAction func unwindToIntro(unwindSegue: UIStoryboardSegue) {
    }
    
}

// this func returns number of columns in a picker
extension IntroViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
// this returns number of rows in a picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
}

// populating rows with actual data from options list
extension IntroViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = Int(options[row]) ?? 2
    }
    
    // passing number of people to the next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Subtotal" {
            let SubtotalViewController = segue.destination as! SubtotalViewController
            SubtotalViewController.people = selectedOption
        }
    }
    
}




    


    


