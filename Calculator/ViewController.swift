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
    
    var userIsTyping:Bool = false,
        previousNumber:Double = 0,
        currentOperation:String?
    
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
            return Double(outputScreen.text!)!
        }
        set (input){
            outputScreen.text = formatter.string(from: NSNumber(value: input))
        }
    }

    @IBAction func touchDigit(_ sender: UIButton) {
        let digit:String = sender.currentTitle!
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
    
    func calculate(first:Double, with operation:String?, second:Double) -> Double? {
        if operation == nil {
            return second
        }
        switch (operation!) {
            case "*":
                return first * second
            case "/":
                if (second == 0) {
                    outputScreen.text = "Err"
                    return nil
                }
                return first / second
            case "-":
                return first - second
            case "+":
                return first + second
            case "%":
                return first / 100.0 * second
            case "^":
                return pow(first, second)
            default:
                return second
        }
        
    }
    
    @IBAction func touchAction(_ sender: UIButton) {
        userIsTyping = false
        switch (sender.currentTitle!) {
            case "*", "/", "-", "+", "%", "^":
                currentOperation = sender.currentTitle!
                previousNumber = screenValue
            case "=":
                let result = self.calculate(first: previousNumber, with: currentOperation, second: screenValue)
                if result != nil {
                    screenValue = result!
                    previousNumber = result!
                }
            case "C":
                previousNumber = 0
                currentOperation = nil
                fallthrough
            case "CE":
                screenValue = 0
            default:
                break
        }
    }
}

