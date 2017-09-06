//
//  DMCFilterBarButton.swift
//  Pods
//
//  Created by David on 23/8/17.
//
//

import UIKit

@objc protocol DMCFilterBarButtonDelegate: class {
    
    @objc optional func filterBarButton(_ filterBarButton: DMCFilterBarButton, didSelectFilter filter: DMCFilter)
}

class DMCFilterBarButton: UIView {
    
    weak var delegate: DMCFilterBarButtonDelegate?
    var filters: [DMCFilter]
    var filterButtons: [DMCFilterButton] = []
    
    // MARK: Lifecycle
    public convenience init(_ filters:[DMCFilter]) {
        self.init()
        self.filters = filters
    }
    
    override init(frame: CGRect) {
        self.filters = []
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    public func customizeView() {
        
        // Self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        
        // ScrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
        // Filter Buttons
        var filterButtons = [DMCFilterButton]()
        for filter in filters {
            let filterButton = DMCFilterButton()
            filterButton.translatesAutoresizingMaskIntoConstraints = false
            filterButton.setTitle(filter.name, for: .normal)
            filterButton.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
            filterButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
            filterButton.tag = filter.id
            filterButton.addTarget(self, action: #selector(didFilterButtonPressed(filterButton:)), for: UIControlEvents.touchUpInside)
            filterButtons.append(filterButton)
        }
        self.filterButtons = filterButtons
        
        // StackView
        let stackView = UIStackView(arrangedSubviews: filterButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 5.0
        scrollView.addSubview(stackView)
        
        // Constaints
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func didFilterButtonPressed(filterButton button: DMCFilterButton) {
        
        for filterButton in self.filterButtons {
            if filterButton != button {
                filterButton.isSelected = false
            }
        }
        
        button.isSelected = !button.isSelected
        if let filterSelected = self.filters.first(where: {$0.id == button.tag}) {
            self.delegate?.filterBarButton?(self, didSelectFilter: filterSelected)
        }
    }
}
