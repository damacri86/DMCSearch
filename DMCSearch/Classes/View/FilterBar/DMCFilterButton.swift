//
//  DMCFilterButton.swift
//  Pods
//
//  Created by David on 23/8/17.
//
//

import UIKit

class DMCFilterButton: UIButton {

    let selectedView: UIView
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        
        self.selectedView = UIView()
        
        super.init(frame: frame)
        self.customizeView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override
    override var isSelected: Bool {
        didSet {
            self.selectedView.isHidden = !isSelected
            
            if isSelected {
                self.setTitleColor(UIColor.black, for: .normal)
            } else {
                self.setTitleColor(UIColor.gray, for: .normal)
            }
        }
    }
    
    // MARK: Private
    func customizeView() {
        
        // Self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        self.titleLabel?.font = UIFont.systemFont(ofSize: 11.0)
        self.setTitleColor(UIColor.gray, for: .normal)
    
        // Selected view
        self.selectedView.translatesAutoresizingMaskIntoConstraints = false
        self.selectedView.backgroundColor = UIColor.black
        self.selectedView.isHidden = true
        self.addSubview(self.selectedView)
        
        // Constraints
        self.selectedView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        self.selectedView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        self.selectedView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.selectedView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    }
}
