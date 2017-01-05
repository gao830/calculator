//
//  ViewController.swift
//  Retro-calculator
//
//  Created by Bill Gao on 2017/1/4.
//  Copyright © 2017年 Bill Gao. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var btnSound: AVAudioPlayer!
    
    @IBOutlet weak var counter: UILabel!
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    var currentOperator = Operation.Empty
    var runningNum = ""
    var leftValue = "0"
    var rightValue = "0"
    var result = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    @IBAction func btnPressed(sender: UIButton){
        playSound()
        runningNum += "\(sender.tag)"
        counter.text = runningNum
    }

    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    
    @IBAction func dividePressed(sender: AnyObject) {
        processOperation(operation: Operation.Divide)
    }
    
   
    @IBAction func multiplyPressed(sender: AnyObject) {
        processOperation(operation: Operation.Multiply)
    }
    
    @IBAction func addPressed(sender: AnyObject) {
        processOperation(operation: Operation.Add)
    }
    
    @IBAction func subtractPressed(sender: AnyObject) {
        processOperation(operation: Operation.Subtract)
    }
    
    @IBAction func equalPressed(sender: AnyObject) {
        processOperation(operation: currentOperator)
    }
    
   
  
    @IBAction func clear(_ sender: Any) {
        print("clear")
        playSound()
        runningNum = ""
        leftValue = "0"
        rightValue = "0"
        result = "0"
        counter.text = "0"
        currentOperator = Operation.Empty
    }
    
    
    
    func processOperation(operation: Operation){
        playSound()
        if currentOperator == Operation.Empty{
            if runningNum == "" {
                runningNum = "0"
            }
            leftValue = runningNum
            runningNum = ""
            currentOperator = operation
        } else {
            if runningNum != ""{
                rightValue = runningNum
                runningNum = ""
                if currentOperator == Operation.Add{
                    result = "\(Double(leftValue)! + (Double(rightValue)!))"
                } else if currentOperator == Operation.Subtract{
                    result = "\(Double(leftValue)! - (Double(rightValue)!))"
                } else if currentOperator == Operation.Multiply{
                    result = "\(Double(leftValue)! * (Double(rightValue)!))"
                } else if currentOperator == Operation.Divide{
                    result = "\(Double(leftValue)! / (Double(rightValue)!))"
                }
            }
            leftValue = result
            counter.text = result
            currentOperator = operation
        }

    }
}
