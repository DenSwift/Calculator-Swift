//
//  ViewController.swift
//  TurboCalculator
//
//  Created by Денис  on 03.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var settingsForAllButtons: [UIButton]!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    var number: String = ""
    var currentResult: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingForAllButtons()
    }
    
    // UI settings for all buttons on screen
    private func settingForAllButtons() {
        settingsForAllButtons.forEach({ button in
            button.layer.cornerRadius = 38
        })
    }
    
    //MARK: - IBActions
    @IBAction func numbersButtons(_ sender: UIButton) {
       
        if resultLabel.text!.count < 15 {
            if sender.tag == 0 {
                if number.first == "0" {
                    number.removeFirst()
                }
                number += "0"
            } else if sender.tag == 1 {
                if number.first == "0" {
                    number.removeFirst()
                }
                number += "1"
            } else if sender.tag == 2 {
                if number.first == "0" {
                    number.removeFirst()
                }
                number += "2"
            } else if sender.tag == 3 {
                if number.first == "0" {
                    number.removeFirst()
                }
                number += "3"
            } else if sender.tag == 4 {
                if number.first == "0" {
                    number.removeFirst()
                }
                number += "4"
            } else if sender.tag == 5 {
                if number.first == "0" {
                    number.removeFirst()
                }
                number += "5"
            } else if sender.tag == 6 {
                if number.first == "0" {
                    number.removeFirst()
                }
                number += "6"
            } else if sender.tag == 7 {
                if number.first == "0" {
                    number.removeFirst()
                }
                number += "7"
            } else if sender.tag == 8 {
                if number.first == "0" {
                    number.removeFirst()
                }
                number += "8"
            } else if sender.tag == 9 {
                if number.first == "0" {
                    number.removeFirst()
                }
                number += "9"
            }
            
            resultLabel.text = number
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Вы ввели слишком большое число!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func deleteLastNumber(_ sender: UIButton) {
        
        if number != "" {
            number.removeLast()
        } else if number.count == 0 {
            let alert = UIAlertController(title: "Ошибка", message: "Введите цифры!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                self.resultLabel.text = "0"
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        
        resultLabel.text = number
    }
    
    @IBAction func deleteAll(_ sender: UIButton) {
        number.removeAll()
        resultLabel.text = "0"
        resultButton.titleLabel?.text = "0"
    }
    
    @IBAction func floatNumberButton(_ sender: UIButton) {
        number += "."
        resultLabel.text = number
    }
    
    @IBAction func percentButton(_ sender: UIButton) {
        if !number.isEmpty {
            addTwoNumbers(value: "%")
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Введите знак процента после числа!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func resultButtonAction(_ sender: UIButton) {
        resultLabel.text = currentResult
        number = currentResult
    }
    
    @IBAction func operations(_ sender: UIButton) {
        
        if sender.tag == 10 {
            devisionOnZero()
            if number == "" {
                number = "0"
            }
            if validInput() && validInputForMinus() && validInputForPercent() {
                let checkedWorkingsForPercent = number.replacingOccurrences(of: "%", with: "*0.01")
                let expression = NSExpression(format: checkedWorkingsForPercent)
                let result = expression.expressionValue(with: nil, context: nil) as! Double
                let resultString = formatResult(result: result)
                currentResult = resultString
                resultButton.titleLabel?.text = resultString
            } else {
                let alert = UIAlertController(title: "Ошибка", message: "Неправильно введенные символы", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { _ in
                    self.number = ""
                    self.resultLabel.text = "0"
                }
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        } else if sender.tag == 11 {
            addTwoNumbers(value: "+")
        } else if sender.tag == 12 {
            addTwoNumbers(value: "-")
        } else if sender.tag == 13 {
            addTwoNumbers(value: "*")
        } else if sender.tag == 14 {
            addTwoNumbers(value: "/")
        }
    }
    
    // MARK: Functions
    func validInput() -> Bool {
        var count = 0
        var charIndexes = [Int]()
        var previous: Int = -1
        
        for char in number {
            if specialCharacter(char: char) {
                charIndexes.append(count)
            }
            count += 1
        }
        
        for index in charIndexes {
            if index == 0 {
                return false
            } else if (index == number.count - 1) {
                return false
            } else if previous != -1 {
                if index - previous == 1 {
                    return false
                }
            }
            previous = index
        }
        return true
    }
    
    func validInputForMinus() -> Bool {
        if number.last == "-" {
            return false
        }
        return true
    }
    
    func validInputForPercent() -> Bool {
        if number.contains("%+%") {
            return false
        } else if number.contains("%-%") {
            return false
        } else if number.contains("%/%") {
            return false
        } else if number.contains("%*%") {
            return false
        }
        return true
    }
    
    func specialCharacter(char: Character) -> Bool {
        if char == "*" {
            return true
        } else if char == "/" {
            return true
        } else if char == "+" {
            return true
        } else if char == "." {
            return true
        }
        return false
    }
    
    func addTwoNumbers(value: String)  {
        number = number + value
        resultLabel.text = number
    }
    
    func devisionOnZero() {
        if number.contains("/0") {
            let alert = UIAlertController(title: "Ошибка", message: "На ноль делить нельзя!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                self.number = ""
                self.resultLabel.text = "0"
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    func formatResult(result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
}


