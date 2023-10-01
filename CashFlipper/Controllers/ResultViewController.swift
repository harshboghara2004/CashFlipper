//
//  ResultViewController.swift
//  CashFlipper
//
//  Created by Boghara on 01/10/23.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var convertedAmount: UILabel!
    @IBOutlet weak var infoField: UILabel!
    @IBOutlet weak var extraInfoField: UILabel!
    
    var fromCurrency: String = "INR"
    var toCurrency: String = "USD"
    var rate: Double = 83.08
    var amount: Double = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertedAmount.text = String(format: "%.2f", (amount*rate))
        infoField.text = "1 \(fromCurrency) is equals to \(String(format: "%.2f",rate)) \(toCurrency)."
        extraInfoField.text = "So \(amount) \(fromCurrency) is equal to \(String(format: "%.2f", (amount*rate))) \(toCurrency)."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

}
