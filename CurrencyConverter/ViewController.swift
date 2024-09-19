//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Farih Muhammad on 19/09/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currencyNameOne: UILabel!
    @IBOutlet weak var currencyNameTwo: UILabel!
    @IBOutlet weak var currencyNumOne: UILabel!
    @IBOutlet weak var currencyNumTwo: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource=self
        currencyPicker.delegate=self
    }


}

extension ViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    
    
}

extension ViewController: UIPickerViewDelegate{
    
}
