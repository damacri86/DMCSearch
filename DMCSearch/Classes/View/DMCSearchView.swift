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
}


public class DMCSearchView: UIView, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate, DMCFilterBarButtonDelegate {

    public weak var datasource: DMCSearchViewDataSource?
    public weak var delegate: DMCSearchViewDelegate?
    public var searchBar: UISearchBar

    var tableView: UITableView
    var filters: [DMCFilter] = []
    
    // MARK: Lifecycle
    public convenience init(filters arrayfilters:[DMCFilter]) {
        
        self.init()
        self.filters = arrayfilters
    }
    
    override init(frame: CGRect) {
        
        self.tableView = UITableView()
        self.searchBar = UISearchBar()
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
        
        // Container View
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.white
        self.addSubview(containerView)

        // Search Bar
        self.searchBar.delegate = self
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.searchBarStyle = .minimal
        self.searchBar.backgroundColor = UIColor.white
        containerView.addSubview(self.searchBar)
        
        // Filter Bar
        let filterBarButton = DMCFilterBarButton(self.filters)
        filterBarButton.translatesAutoresizingMaskIntoConstraints = false
        filterBarButton.delegate = self
        filterBarButton.customizeView()
        self.addSubview(filterBarButton)
        
        // Table View
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorColor = UIColor.clear
        self.tableView.register(DMCTableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.addSubview(self.tableView)
        
        // Constaints
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        self.searchBar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        self.searchBar.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        self.searchBar.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        self.searchBar.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        filterBarButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        filterBarButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        filterBarButton.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 1.0).isActive = true
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
        if let unwrappedDataSource = self.datasource {
            if (unwrappedDataSource.searchObjects(in: self).count > 0) {
                self.tableView.scrollToRow(at:IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
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
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! DMCTableViewCell;
        
        if let searchObject = self.datasource?.searchObjects(in: self)[indexPath.row] {

            cell.cellTitleLabel?.text = searchObject.name
            cell.cellTextLabel?.text = searchObject.text
            cell.cellImageView?.image = UIImage(named: searchObject.imageName)
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return DMCTableViewCell.cellHeight()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.searchView!(self, didSelectSearchObject: (self.datasource?.searchObjects(in: self)[indexPath.row])!)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: UISearchBarDelegate
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.delegate?.searchView?(self, textDidChange: searchText)
    }
    
    // MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.searchBar.resignFirstResponder()
    }
}
