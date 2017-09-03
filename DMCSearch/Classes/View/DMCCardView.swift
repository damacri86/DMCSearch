//
//  DMCCardView.swift
//  Pods
//
//  Created by David on 23/8/17.
//
//

import UIKit

class DMCCardView: UIView {

    let imageView: UIImageView
    let titleLabel: UILabel
    let viewLabel: UIView

    // MARK: Lifecycle
    override init(frame: CGRect) {
        
        self.imageView = UIImageView()
        self.titleLabel = UILabel()
        self.viewLabel = UIView()
        super.init(frame: frame)
        self.customizeView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    func customizeView() {
        
        // Self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.orange
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        
        let gradient = CAGradientLayer()
        gradient.frame = self.viewLabel.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        self.viewLabel.layer.insertSublayer(gradient, at: 0)
        
        
        // Image View
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)

        // View Label
        self.viewLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.viewLabel)
        
        // Title Label
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.addSubview(self.titleLabel)

        // Constraints
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        self.viewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.viewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.viewLabel.heightAnchor.constraint(equalToConstant: 52.0).isActive = true
        self.viewLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:16.0).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 21.0).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0).isActive = true
    }
    
}
