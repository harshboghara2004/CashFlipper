//
//  ViewController.swift
//  CashFlipper
//
//  Created by Boghara on 17/09/23.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var amountField: UITextField!
    @IBOutlet var fromCurrencyPicker: UIPickerView!
    @IBOutlet var toCurrencyPicker: UIPickerView!
    
    var currencyManager = CurrencyManager()
    var amount: Double = 1
    var rate: Double = 80
    var fromCurrency: String = "USD"
    var toCurrency: String = "INR"

    override func viewDidLoad() {
        super.viewDidLoad()
        fromCurrencyPicker.dataSource = self
        fromCurrencyPicker.delegate = self
        toCurrencyPicker.dataSource = self
        toCurrencyPicker.delegate = self
        currencyManager.delegate = self
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        amount = (Double(amountField.text ?? "1") ?? 1.0)
        print(rate)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let dest = segue.destination as! ResultViewController
            dest.amount = amount
            dest.rate = rate
            dest.fromCurrency = fromCurrency
            dest.toCurrency = toCurrency
        }
    }
    
}

// MARK: - UIPickerView

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        amountField.endEditing(true)
        if pickerView == fromCurrencyPicker {
            currencyManager.fromCur = currencyManager.currencyArray[row]
        } else if pickerView == toCurrencyPicker {
            currencyManager.toCur = currencyManager.currencyArray[row]
        }
        currencyManager.calculate()
    }
}

// MARK: - CurrencyManagerDelegate

extension ViewController: CurrencyManagerDelegate {
    func didUpdateCurrencyValue(currencyManager: CurrencyManager, currency: CurrencyModel) {
        DispatchQueue.main.async {
            self.fromCurrency = currency.fromCurrency
            self.toCurrency = currency.toCurrency
            self.rate = currency.rate
        }
    }
    
    func didFailWithCurrency(error: Error) {
        print("me")
        print(error)
    }
    
}
