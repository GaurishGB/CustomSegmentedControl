//
//  ViewController.swift
//  CustomSegmentedControl
//
//  Created by Gaurish on 26/09/19.
//  Copyright © 2019 GB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: GBSegmentedControl!
    @IBOutlet weak var segmentedSliderControl: GBSegmentedSliderControl!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didChangeValue(_ sender: GBSegmentedControl) {
        infoLabel.text = "Selected segment index : \(sender.selectedSegmentIndex)"
    }
    
    @IBAction func didChangeControlValue(_ sender: GBSegmentedSliderControl) {
    }
    
    
    @IBAction func didTapButton(_ sender: UIButton) {
        print(textField.text ?? 0)
        segmentedControl.changeSelectedSegmentIndex = Int(textField.text!) ?? 0
        segmentedSliderControl.changeSelectedSegmentIndex = Int(textField.text!) ?? 0
    }
    


}

