//
//  DMCSearchView.swift
//  Pods
//
//  Created by David on 23/8/17.
//
//

import UIKit

@objc public protocol DMCSearchViewDataSource: class {
    
    func searchObjects(in searchView: DMCSearchView) -> [DMCSearchObject]
}

@objc public protocol DMCSearchViewDelegate: class {
    
    @objc optional func searchView(_ searchView: DMCSearchView, didSelectSearchObject searchObject: DMCSearchObject)
    @objc optional func searchView(_ searchView: DMCSearchView, didSelectFilter filter: DMCFilter)

    @objc optional func searchView(_ searchView: DMCSearchView, textDidChange searchText: String)
    @objc optional func searchViewCancelButtonTapped(_ searchView: DMCSearchView)
}


public class DMCSearchView: UIView, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, DMCFilterBarButtonDelegate {

    public weak var datasource: DMCSearchViewDataSource?
    public weak var delegate: DMCSearchViewDelegate?
    
    var tableView: UITableView
    var filters: [DMCFilter] = []
    
    // MARK: Lifecycle
    public convenience init(_ filters:[DMCFilter]) {
        self.init()
        self.filters = filters
        self.tableView = UITableView()
    }
    
    override init(frame: CGRect) {
        
        self.tableView = UITableView()
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    public func customizeView() {
        
        // Self
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.init(red: 229.0/255.0, green: 230.0/255.0, blue: 233.0/255.0, alpha: 1.0)
        
        // Search Bar
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = UIColor.white
        searchBar.setShowsCancelButton(true, animated: false)
        addSubview(searchBar)
        
        // Filter Bar
        let filterBarButton = DMCFilterBarButton(self.filters)
        filterBarButton.translatesAutoresizingMaskIntoConstraints = false
        filterBarButton.delegate = self
        filterBarButton.customizeView()
        self.addSubview(filterBarButton)
        
        // Table View
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = UIColor.white
        self.tableView.register(DMCTableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.addSubview(self.tableView)
        
        // Constaints
        searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        filterBarButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        filterBarButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        filterBarButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 1.0).isActive = true
        filterBarButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: filterBarButton.bottomAnchor, constant: 1.0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    public func updateContent() {
        
        self.tableView.reloadData()
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
     
        let cell = DMCTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cellReuseIdentifier")

//        let cell:DMCTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! DMCTableViewCell!
        
        if let searchObject = self.datasource?.searchObjects(in: self)[indexPath.row] {

            cell.textLabel?.text = searchObject.name
            cell.detailTextLabel?.text = searchObject.text
            cell.imageView?.image = UIImage(named: searchObject.imageName)
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.searchView!(self, didSelectSearchObject: (self.datasource?.searchObjects(in: self)[indexPath.row])!)
    }
    
    // MARK: UISearchBarDelegate
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.delegate?.searchView?(self, textDidChange: searchText)
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.delegate?.searchViewCancelButtonTapped?(self)
    }
}
