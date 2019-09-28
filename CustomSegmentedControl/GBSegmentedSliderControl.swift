//
//  GBSegmentedSliderControl.swift
//  CustomSegmentedControl
//
//  Created by Gaurish on 26/09/19.
//  Copyright © 2019 GB. All rights reserved.
//

import UIKit

class GBSegmentedSliderControl: UIControl {
    
    var buttonsArray = [UIButton]()
    var selectedSegmentView: UIView!

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateView()
        //        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView() {
        
        buttonsArray.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        if items.isEmpty {
            return
        }
        
        for item in items {
            let button = UIButton.init(type: .system)
            button.setTitle(item, for: .normal)
            button.setTitleColor(unSelectedSegmentTextColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            buttonsArray.append(button)
        }
        
        buttonsArray[0].setTitleColor(selectedSegmentTextColor, for: .normal)
        
        var selectFrame = self.bounds
        let newWidth = selectFrame.width / CGFloat(buttonsArray.count)
        selectFrame.size.width = newWidth
        
        selectedSegmentView = UIView.init(frame: selectFrame)
        selectedSegmentView.backgroundColor = selectedSegmentColor
        addSubview(selectedSegmentView)
        
        /// Create a StackView for buttons
        self.createStackViewWith(array: buttonsArray)

    }
    
    func createStackViewWith(array:[UIView]) {
        let stackView = UIStackView.init(arrangedSubviews: array)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0.0
        addSubview(stackView) // Adds stackView as subview of self
        
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
        
        for (index,button) in buttonsArray.enumerated() {
            
            button.setTitleColor(unSelectedSegmentTextColor, for: .normal)

            button.setTitleColor(self.unSelectedSegmentTextColor, for: .normal)
            button.isUserInteractionEnabled = true
            
            if index == segmentIndex {
                selectedSegmentIndex = index // Update the selectedSegmentIndex
                
                let  selectedSegmentViewXcoordinate = frame.width / CGFloat(buttonsArray.count) * CGFloat(index)
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.selectedSegmentView.frame.origin.x = selectedSegmentViewXcoordinate
                })
                button.setTitleColor(selectedSegmentTextColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        
        for (index,button) in buttonsArray.enumerated() {
            
            button.setTitleColor(unSelectedSegmentTextColor, for: .normal)
            
            if button == sender {
                selectedSegmentIndex = index
                
                let  selectedSegmentViewXcoordinate = frame.width / CGFloat(buttonsArray.count) * CGFloat(index)
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.selectedSegmentView.frame.origin.x = selectedSegmentViewXcoordinate
                })
                button.setTitleColor(selectedSegmentTextColor, for: .normal)
            }
        }
        
        sendActions(for: .valueChanged)
        
    }
    
}
