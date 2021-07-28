//
//  ViewController.swift
//  Project 1
//
//  Created by Ryan Neil Stroud on 23/7/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var model: UISegmentedControl!
    @IBOutlet weak var upgrades: UISegmentedControl!
    @IBOutlet weak var mileage: UISlider!
    @IBOutlet weak var condition: UISegmentedControl!
    @IBOutlet weak var valuation: UILabel!
    @IBOutlet weak var mileageLabel: UILabel!
    
    private let cars = Cars()
    
    @IBAction func calculateValue(_ sender: Any) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let formattedMileage = formatter.string(for: mileage.value) ?? "0"
        mileageLabel.text = "Mileage (\(formattedMileage))"
        
        if let prediction = try? cars.prediction(
            model: Double(model.selectedSegmentIndex),
            premium: Double(upgrades.selectedSegmentIndex),
            mileage: Double(mileage.value),
            condition: Double(condition.selectedSegmentIndex)
        ) {
            let clampedValuation = max(2000, prediction.price)
            formatter.numberStyle = .currency
            valuation.text = formatter.string(for: clampedValuation)
        } else {
            valuation.text = "Error!"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateValue(self)
    }


}

