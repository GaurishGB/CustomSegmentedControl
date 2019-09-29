//
//  GBSegmentedControl.swift
//  CustomSegmentedControl
//
//  Created by Gaurish on 26/09/19.
//  Copyright © 2019 GB. All rights reserved.
//
var counter:Int = 0
import UIKit

@IBDesignable
class GBSegmentedControl: UIControl {
    
    var buttonsArray = [UIButton]()
    var segmentViewArray = [UIView]()
    
    private(set) var selectedSegmentIndex: Int = 0
    
    var changeSelectedSegmentIndex: Int = 0 {
        didSet {
            changeSelectedSegment(segmentIndex: changeSelectedSegmentIndex)
        }
    }
    
    private var items: [String] = ["First","Second","Third"]
    
    var segments: [String] = [] {
        didSet {
            items = segments
            updateView()
        }
    }
    
    @IBInspectable var selectedSegmentTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var unSelectedSegmentTextColor: UIColor = .black {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var selectedSegmentColor: UIColor = .green {
        didSet {
            updateView()
        }
    }
    
    var segmentTitleFont: UIFont = UIFont.systemFont(ofSize: 17.0) {
        didSet {
            updateView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateView()
    }
    
    func updateView() {
        
        buttonsArray.removeAll()
        segmentViewArray.removeAll()
        
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        if items.isEmpty {
            return
        }
        
        for item in items {
            /// Creating button
            let button = UIButton.init(type: .system)
            button.setTitle(item, for: .normal)
            button.setTitleColor(unSelectedSegmentTextColor, for: .normal)
            button.titleLabel?.font = segmentTitleFont
            button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
            
            buttonsArray.append(button)
            
            /// Creating segmentView
            let segmentView = UIView.init()
            segmentView.backgroundColor = .clear
            
            segmentViewArray.append(segmentView)
        }
        
        /// To show selection for first segment
        buttonsArray[0].setTitleColor(selectedSegmentTextColor, for: .normal)
        buttonsArray[0].isUserInteractionEnabled = false

        segmentViewArray[0].backgroundColor = selectedSegmentColor
        
        /// Create a StackView for SegmentViews
        self.createStackViewWith(array: segmentViewArray)
        
        /// Create a StackView for Buttons
        self.createStackViewWith(array: buttonsArray)
        
    }
    
    func createStackViewWith(array:[UIView]) {
        let stackView = UIStackView.init(arrangedSubviews: array)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0.0
        addSubview(stackView) // Adds stackView of views as subview
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateView()// To get proper frame for views i.e. segment
        
    }
    
    func changeSelectedSegment(segmentIndex:Int) {
        
        let zipArray = Array(zip(self.buttonsArray, self.segmentViewArray))
        
        for (index,(button,segmentView)) in zipArray.enumerated() {
            
            button.setTitleColor(self.unSelectedSegmentTextColor, for: .normal)
            button.isUserInteractionEnabled = true
            segmentView.backgroundColor = .clear
            
            if index == segmentIndex {
                self.selectedSegmentIndex = index // Update the selectedSegmentIndex
                
                UIView.animate(withDuration: 0.3, animations: {
                    button.setTitleColor(self.selectedSegmentTextColor, for: .normal)
                    button.isUserInteractionEnabled = false
                    segmentView.backgroundColor = self.selectedSegmentColor
                })
            }
        }
    }
    
    @objc func didTapButton(sender: UIButton) {
        
        let zipArray = Array(zip(buttonsArray, segmentViewArray))
        
        for (index,(button,segmentView)) in zipArray.enumerated() {
            
            button.setTitleColor(unSelectedSegmentTextColor, for: .normal)
            button.isUserInteractionEnabled = true
            segmentView.backgroundColor = .clear
            
            if button == sender {
                selectedSegmentIndex = index // Update the selectedSegmentIndex
                
                UIView.animate(withDuration: 0.3, animations: {
                    button.setTitleColor(self.selectedSegmentTextColor, for: .normal)
                    button.isUserInteractionEnabled = false
                    segmentView.backgroundColor = self.selectedSegmentColor
                })
            }
        }
        sendActions(for: .valueChanged)
    }
    
}
