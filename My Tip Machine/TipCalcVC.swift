//
//  TipCalcVC.swift
//  My Tip Machine
//
//  Created by Joseph Pilon on 8/1/16.
//  Copyright © 2016 ios10-devslopes. All rights reserved.
//

import UIKit

class TipCalcVC: UIViewController, UITextFieldDelegate {

    // MARK: IBOultets
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipPercent: UILabel!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var splitNumber: UILabel!
    @IBOutlet weak var splitAmount: UILabel!
    @IBOutlet weak var extraAmountLbl: UILabel!
    
    // MARK: Properties
    var tPercent = 10.0
    var sNumber = 1.0
    var bAmount = 0.0
    var tip = Tip(billAmount: 0.0, tipPercent: 10.0)
    
    
    
    
    // MARK: Initialize Views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipPercent.text = "Tip 10%"
        tipAmount.text = "$0.00"
        totalAmount.text = "$0.00"
        splitAmount.text = "$0.00"
        billAmount.delegate = self
        
        // MARK: Gesture Recognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TipCalcVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    // MARK: IBActions
    @IBAction func tipSlider(_ sender: UISlider) {
        tPercent = round(Double(sender.value))
        tipPercent.text = "TIP \(Int(tPercent))%"
        tip.tipPercent = tPercent
        prepareTip()
    }
    
    @IBAction func splitSlider(_ sender: UISlider) {
        sNumber = round(Double(sender.value))
        splitNumber.text = "SPLIT \(Int(sNumber))"
        tip.splitNumber = sNumber
        prepareTip()
    }

    @IBAction func billAmount(_ sender: AnyObject) {
        if sender.text != "" {
            bAmount = abs(Double(sender.text)!)
        } else {
            bAmount = 0.00
        }
            tip.billAmount = bAmount
            prepareTip()
    }
    
    // MARK: Functions
    func prepareTip() {
        tip.calculateTip()
        tip.calculateSplit()
        if tip.tipAmount == 0.0 {
            tipAmount.text = "$0.00"
        } else {
            tipAmount.text = "$\(tip.tipAmount)"
        }
        if tip.totalAmount == 0.0 {
            totalAmount.text = "$0.00"
        } else {
            totalAmount.text = "$\(tip.totalAmount)"
        }
        if tip.splitAmount == 0.0 {
            splitAmount.text = "$0.00"
        } else {
            splitAmount.text = "$\(tip.splitAmount)"
        }
        extraAmountLbl.text = tip.extraAmountInfo
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Make sure  we can remove all numbers.
        if string == "" {
            return true
        }
        // Only allow numbers and dot
        let inverseSet = NSCharacterSet(charactersIn: "0123456789.").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        if  string == filtered {
            // Only allow 1 dot
            let firstString = textField.text ?? "" as NSString
            let newString = firstString.replacingCharacters(in: range, with: string)
            let regex = try? NSRegularExpression(pattern: "^\\d+(\\.\\d{0,2})?$", options: [])
            return regex?.firstMatch(in: newString, options: [], range: NSRange(location: 0, length: newString.characters.count)) != nil
        }
        return false
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

