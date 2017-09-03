//
//  DMCSearchView.swift
//  Pods
//
//  Created by David on 23/8/17.
//
//

import UIKit

public protocol DMCSearchViewDataSource: class {
    
    func filters(in searchView: DMCSearchView) -> [DMCFilter]
    func searchObjects(in searchView: DMCSearchView) -> [DMCSearchObject]
}

@objc public protocol DMCSearchViewDelegate: class {
    
    @objc optional func searchView(_ searchView: DMCSearchView, didSelectSearchObject searchObject: DMCSearchObject)
    @objc optional func searchView(_ searchView: DMCSearchView, didSelectFilter filter: DMCFilter)
}


public class DMCSearchView: UIView, UITableViewDataSource, UITableViewDelegate, DMCFilterBarButtonDataSource, DMCFilterBarButtonDelegate {

    public weak var datasource: DMCSearchViewDataSource?
    public weak var delegate: DMCSearchViewDelegate?
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    public func customizeView() {
        
        // Self
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.gray
        
        // Status Bar
        
        // Search Bar
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = UIColor.white
        addSubview(searchBar)
        
        // Filter Bar
        let filterBarButton = DMCFilterBarButton()
        filterBarButton.translatesAutoresizingMaskIntoConstraints = false
        filterBarButton.delegate = self
        filterBarButton.datasource = self
        filterBarButton.customizeView()
        self.addSubview(filterBarButton)
        
        // Table View
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
        tableView.delegate = self
        tableView.dataSource = self
        self.addSubview(tableView)
        
        // Constaints
        searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        filterBarButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        filterBarButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        filterBarButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 1.0).isActive = true
        filterBarButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: filterBarButton.bottomAnchor, constant: 1.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    // MARK: DMCFilterBarButtonDataSource
    func filters(in fiterBarButton: DMCFilterBarButton) -> [DMCFilter]? {
    
        return self.datasource?.filters(in: self)
    }

    // MARK: DMCFilterBarButtonDelegate
    func filterBarButton(_ filterBarButton: DMCFilterBarButton, didSelectFilter filter: DMCFilter) {
        
        self.delegate?.searchView!(self, didSelectFilter: filter)
    }
    
    // MARK: UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let unwrappedDataSource = self.datasource {
            return unwrappedDataSource.searchObjects(in: self).count;
        }
        return 0;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as UITableViewCell!
        cell.textLabel?.text = self.datasource?.searchObjects(in: self)[indexPath.row].name
        return cell
    }
    
    // MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.searchView!(self, didSelectSearchObject: (self.datasource?.searchObjects(in: self)[indexPath.row])!)
    }
}
