//
//  ViewController.swift
//  Calculator
//
//  Created by Michael Quintero on 5/31/15.
//  Copyright (c) 2015 Michael Quintero. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    var brain = CalculatorBrain()

    //appends digit to the display
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        //If the user has not pressed enter yet just append
        //the digit to the display
        //If the user has already pressed enter then
        //replace the display with the digit
        if userIsInTheMiddleOfTypingANumber {
           display.text = display.text! + digit
        }
        else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    


    @IBAction func enter() {
        
        userIsInTheMiddleOfTypingANumber = false
       // if let result = //brain.pushOperand(displayValue ){
       //     displayValue = result
       // }
       // else{
       //     displayValue = 0
       // }
    }
    

    
    @IBAction func operate(sender: UIButton) {
//        if userIsInTheMiddleOfTypingANumber {
//            enter()
//        }
//        if let operation = sender.currentTitle{
//            if let result = brain.performOperation(operation){
//                displayValue = result
//            } else{
//                displayValue = 0
//            }
//        }

        
    }

    

    
    var displayValue: Double {
        get{

                return NSNumberFormatter().numberFromString(display.text!)!.doubleValue

           
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }

}

