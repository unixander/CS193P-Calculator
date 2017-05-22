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
    
    var userIsTyping:Bool = false
    var formatter:NumberFormatter {
        let format = NumberFormatter()
        format.minimumFractionDigits = 0
        return format
    }
    
    var previousNumber:Double = 0
    var currentOperation:String?
    var screenContent:Double {
        get {
            return Double(outputScreen.text!)!
        }
        set (input){
            outputScreen.text = formatter.string(from: NSNumber(value: input))
        }
    }

    @IBAction func touchDigit(_ sender: UIButton) {
        let digit:String = sender.currentTitle!
        if (userIsTyping) {
            screenContent = screenContent * 10 + Double(digit)!
        } else {
            screenContent = Double("\(digit)")!
            userIsTyping = true
        }
    }
    
    func calculate(first:Double, with operation:String?, second:Double) -> Double? {
        if (operation == nil) {
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
            default:
                return second
        }
        
    }
    
    @IBAction func touchAction(_ sender: UIButton) {
        userIsTyping = false
        switch (sender.currentTitle!) {
            case "*", "/", "-", "+":
                currentOperation = sender.currentTitle!
                previousNumber = screenContent
            case "=":
                var result = self.calculate(first: previousNumber, with: currentOperation, second: screenContent)
                if (result != nill) {
                    screenContent = result
                    previousNumber = result
                }
            case "C":
                screenContent = 0
                previousNumber = 0
                currentOperation = nil
            default:
                break
        }
    }
}

