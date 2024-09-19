//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Farih Muhammad on 19/09/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currencyNameOne: UILabel!
    @IBOutlet weak var currencyNumOne: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
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
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                        DispatchQueue.main.async {
                            print(jsonResponse)
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

extension ViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    
}

extension ViewController: UIPickerViewDelegate{
    
}


