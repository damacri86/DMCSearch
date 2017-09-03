//
//  DMCCardBarView.swift
//  Pods
//
//  Created by David on 23/8/17.
//
//

import UIKit

class DMCCardBarView: UIView {

    let scrollView: UIScrollView

    // MARK: Lifecycle
    override init(frame: CGRect) {
        
        self.scrollView = UIScrollView()
        
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
        
        // ScrollView
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.backgroundColor = UIColor.gray
        self.scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        
        // Top Search
        var searchCards = [DMCCardView]()
        for _ in [1,2,3,4,5,6] {
            
            let searchCard = DMCCardView()
            searchCard.translatesAutoresizingMaskIntoConstraints = false
            searchCard.titleLabel.text = ":)"
            searchCard.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            searchCards.append(searchCard)
        }
        
        let stackView = UIStackView(arrangedSubviews: searchCards)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 5.0
        self.scrollView.addSubview(stackView)
        
        // Constaints
        self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
    }

}
