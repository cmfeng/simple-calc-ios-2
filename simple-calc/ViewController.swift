//
//  ViewController.swift
//  simple-calc
//
//  Created by cmfeng on 10/21/16.
//  Copyright © 2016 com.ischool.cmfeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //get and restore the input
    public var cur = 0
    public var operands: [Int] = []
    public var operators: [String] = []
    //function to get the string for current operation
    //other than fact
    func getThisHist() -> String{
        var s = "\(operands[0])"
        operands.remove(at: 0)
        for i in 0...(operators.count - 1){
            s += " \(operators[i]) \(operands[i])"
        }
        s += " = \(self.textField.text!)"
        return s
    }
    //get fact operation string
    func getFactHis() -> String{
        let s = "\(operands[0]) fact = \(self.textField.text!)"
        return s
    }
    //To add the string to Default history array
    func addThisHis(s: String) -> () {
        var arr = UserDefaults.standard.array(forKey: "hist")
        if arr == nil{
            arr = Array()
        }
        arr!.insert(s, at: 0)
        UserDefaults.standard.set(arr, forKey: "hist")
    }
    //function called when input is an integer
    func addNum(invalue: Int){
        if (cur < 10000000){
        self.cur = cur * 10 + invalue
        self.textField.text = String(cur)
        } else {
            self.textField.text = "Overflow of Integer"
        }
        
    }
    //function called when input is an operator
    func addOpe(invalue: String){
        self.operands.append(self.cur)
        self.operators.append(invalue)
        self.cur = 0
    }
    //function for factorial
    func factorial(n: Int) -> Int{
        if (n <= 1) {
            return 1
        }
        return (n * factorial(n: (n - 1)))
    }
    //check if all the elements in the array are the same
    func sameOp(array: [String]) -> Bool{
        if array.count < 2{
            return true
        }
        for i in 0...(array.count - 2){
            if array[i] != array[i + 1] {
                return false
            }
        }
        return true
    }
    func average(array: [Int]) -> Int{
        var sum = 0
        for i in 0...(array.count - 1){
            sum += array[i]
        }
        return sum / array.count
    }
    //function includding basic binary operations
    func binaryOp(opt : String, opd: [Int]) {
        switch opt{
        case("+"):
            let result = opd[0] + opd [1]
            self.textField.text = String(result)
        case("-"):
            let result = opd[0] - opd [1]
            self.textField.text = String(result)
        case("*"):
            let result = opd[0] * opd [1]
            self.textField.text = String(result)
        case("/"):
            if opd[1] == 0 {
                self.textField.text = "Not supporting diveding by 0"
            } else {
                let result = opd[0] / opd [1]
                self.textField.text = String(result)
            }
        case("%"):
            let result = opd[0] % opd [1]
            self.textField.text = String(result)
        default:
            self.textField.text = "unsupported operation"
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func clear(_ sender: AnyObject) {
        self.cur = 0
        self.operators = []
        self.operands = []
        self.textField.text = ""
    }
    @IBAction func add(_ sender: AnyObject) {
        self.addOpe(invalue: "+")
    }
    @IBAction func sub(_ sender: AnyObject) {
        self.addOpe(invalue: "-")
    }
    @IBAction func mul(_ sender: AnyObject) {
        self.addOpe(invalue: "*")
    }
    @IBAction func div(_ sender: AnyObject) {
        self.addOpe(invalue: "/")
    }
    @IBAction func mod(_ sender: AnyObject) {
        self.addOpe(invalue: "%")
    }
    
    @IBAction func fact(_ sender: AnyObject) {
        self.operands.append(self.cur)
        let l = self.operands.count
        if (l != 1 || self.operators.count != 0) {
            self.textField.text = "Invalid input: Only accept one number"
        } else {
            let result = factorial(n: self.operands[0])
            self.textField.text = String(result)
        }
        let s = self.getFactHis()
        self.addThisHis(s: s)
        self.operands = []
        self.cur = 0
        self.operators = []
        
    }
    @IBAction func avg(_ sender: AnyObject) {
        self.addOpe(invalue: "avg")
    }
    @IBAction func count(_ sender: AnyObject) {
        self.addOpe(invalue: "count")
    }
    @IBAction func zero(_ sender: AnyObject) {
        self.addNum(invalue: 0)
    }
    @IBAction func one(_ sender: AnyObject) {
        self.addNum(invalue: 1)
    }
    @IBAction func two(_ sender: AnyObject) {
        self.addNum(invalue: 2)
    }
    @IBAction func three(_ sender: AnyObject) {
        self.addNum(invalue: 3)
    }
    @IBAction func four(_ sender: AnyObject) {
        self.addNum(invalue: 4)
    }
    @IBAction func five(_ sender: AnyObject) {
        self.addNum(invalue: 5)
    }
    @IBAction func six(_ sender: AnyObject) {
        self.addNum(invalue: 6)
    }
    @IBAction func seven(_ sender: AnyObject) {
        self.addNum(invalue: 7)
    }
    @IBAction func eight(_ sender: AnyObject) {
        self.addNum(invalue: 8)
    }
    @IBAction func nine(_ sender: AnyObject) {
        self.addNum(invalue: 9)
    }
    @IBAction func equal(_ sender: AnyObject) {
        self.operands.append(self.cur)
        if (operators.count == 0){
            self.textField.text = "Operator needed!"
        } else if (operators[0] == "count" && sameOp(array: operators)) {
            self.textField.text = String(operands.count)
        } else if (operators[0] == "avg" && sameOp(array: operators)){
            self.textField.text = String(average(array: operands))
        } else if (operators.count == 1 && operands.count == 2){
            binaryOp(opt: operators[0], opd: operands)
        } else {
            self.textField.text = "Not supported operation yet"
        }
        let s = self.getThisHist()
        self.addThisHis(s: s)
        self.operands = []
        self.operators = []
        self.cur = 0
        
    }

}

