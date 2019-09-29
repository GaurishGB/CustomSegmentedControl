//
//  ViewController.swift
//  CustomSegmentedControl
//
//  Created by Gaurish on 26/09/19.
//  Copyright © 2019 GB. All rights reserved.
//
var counter1:Int = 0
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var uiSegmentedControl: UISegmentedControl!
    @IBOutlet weak var gbSegmentedControl: GBSegmentedControl!
    @IBOutlet weak var gbSegmentedSliderControl: GBSegmentedSliderControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
    @IBAction func didChangeUISegmentedControlValue(_ sender: UISegmentedControl) {
        changeSelection(index: sender.selectedSegmentIndex)
    }
    
    @IBAction func didChangeGBSegmentedControlValue(_ sender: GBSegmentedControl) {
        changeSelection(index: sender.selectedSegmentIndex)
    }
    
    @IBAction func didChangeGBSegmentedSliderControlValue(_ sender: GBSegmentedSliderControl) {
        changeSelection(index: sender.selectedSegmentIndex)
    }
    
    func changeSelection(index:Int) {
        uiSegmentedControl.selectedSegmentIndex = index
        gbSegmentedControl.changeSelectedSegmentIndex = index
        gbSegmentedSliderControl.changeSelectedSegmentIndex = index
    }

}

