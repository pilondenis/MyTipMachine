//
//  Tip.swift
//  My Tip Machine
//
//  Created by Joseph Pilon on 8/1/16.
//  Copyright © 2016 ios10-devslopes. All rights reserved.
//

import Foundation

class Tip {
    private var _billAmount = 0.00
    private var _tipPercent = 0.00
    private var _tipAmount = 0.00
    private var _totalAmount = 0.00
    private var _splitNumber = 1.0
    private var _splitAmount = 0.00
    private var _extraAmountInto = ""
    
    var billAmount: Double {
        get {
            return _billAmount
        }
        set {
            _billAmount = newValue
        }
    }
    
    var tipPercent: Double {
        get {
            return _tipPercent
        }
        set {
            _tipPercent = newValue
        }
    }
    
    var tipAmount: Double {
        return _tipAmount
    }
    
    var totalAmount: Double {
        return _totalAmount
    }
    
    var splitNumber: Double {
        get {
            return _splitNumber
        }
        set {
            _splitNumber = newValue
        }
    }
    
    var splitAmount: Double {
        return _splitAmount
    }
    
    var extraAmountInfo: String {
        return _extraAmountInto
    }
    
    init(billAmount: Double, tipPercent: Double) {
        self.billAmount = billAmount
        self.tipPercent = tipPercent
        calculateTip()
        calculateSplit()
    }
    
    func calculateTip() {
        _tipAmount = round(billAmount * (tipPercent / 100) * 100) / 100
        _totalAmount = billAmount + _tipAmount
    }
    
    func calculateSplit() {
        _splitAmount = round(_totalAmount / _splitNumber * 100 ) / 100
        let extra = _totalAmount - (_splitAmount * _splitNumber)
        if extra >= 0.01 {
            _extraAmountInto = "One person will need to pay $\(String(format: "%0.2f", extra)) more."
        } else if extra < 0.00  && _splitNumber > 1.0{
            _extraAmountInto = "One person will need to pay $\(String(format: "%0.2f", abs(extra))) less."
        } else {
            _extraAmountInto = ""
        }
    }
}
