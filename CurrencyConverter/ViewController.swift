//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Farih Muhammad on 19/09/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyNum: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var currencies = [String : Double]()
    var currencyKeys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource=self
        currencyPicker.delegate=self
        getRates()
    }
    
    func getRates(){
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsing & JSON Sterialization
        
//        1)
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=313adb6cf0ddf4484935be7e12ca1eba")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
//                2)
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String, Any>
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String: Double] {
                                // Get all currency codes and sort them alphabetically
                                self.currencies = rates
                                self.currencyKeys = Array(rates.keys).sorted() // Sort the currency keys
                                self.currencyPicker.reloadAllComponents() // Reload picker with new data
                            }
                        }
                        
                    } catch {
                        print("error")
                    }
                }
            }
        }
        task.resume()
    }
    
    
}

// MARK: - UIPickerView DataSource and Delegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Single column
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count // Number of currencies
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyKeys[row] // Display currency codes
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = currencyKeys[row] // Get the selected currency code
        let currencyRate = currencies[selectedCurrency]! // Get the corresponding rate
        
        // Update the labels with the selected currency code and its rate
        DispatchQueue.main.async {
            self.currencyName.text = selectedCurrency
            self.currencyNum.text = String(format: "%.4f", currencyRate) // Format the rate with 4 decimal places
        }
        
    }
}

