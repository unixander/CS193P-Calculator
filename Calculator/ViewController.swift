//
//  ViewController.swift
//  Calculator
//
//  Created by Alexander on 21/05/2017.
//  Copyright © 2017 Unixander Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var outputScreen: UILabel!
    var brain: CalculatorBrain = CalculatorBrain()
    
    var userIsTyping:Bool = false
    
    var formatter:NumberFormatter {
        let format = NumberFormatter()
        format.minimumSignificantDigits = 0
        return format
    }
    
    var screenContent:String {
        get {
            return outputScreen.text!
        }
        set (input) {
            outputScreen.text = input
        }
    }
    var screenValue:Double {
        get {
            return Double(outputScreen.text!) ?? 0
        }
        set (input){
            outputScreen.text = formatter.string(from: NSNumber(value: input))
        }
    }

    @IBAction func touchDigit(_ sender: UIButton) {
        if let digit = sender.currentTitle {
            if userIsTyping {
                if digit != "." || !screenContent.contains(digit) {
                    screenContent += digit
                }
            } else if digit == "." {
                screenContent = "0\(digit)"
            } else {
                screenContent = digit
                userIsTyping = true
            }
        }
    }
    
    @IBAction func touchAction(_ sender: UIButton) {
        userIsTyping = false
        brain.setOperand(screenValue)
        if let operation = sender.currentTitle {
            brain.performOperation(operation)
            if let result = brain.result {
                screenValue = result
            }
        }
    }
}

