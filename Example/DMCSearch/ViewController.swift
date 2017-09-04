//
//  ViewController.swift
//  DMCSearch
//
//  Created by damacri86 on 08/23/2017.
//  Copyright (c) 2017 damacri86. All rights reserved.
//

import UIKit
import DMCSearch

class ViewController: UIViewController, DMCSearchViewDataSource, DMCSearchViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarView = UIView()
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        statusBarView.backgroundColor = UIColor.white
        self.view.addSubview(statusBarView)
        
        let searchView = DMCSearchView()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.delegate = self
        searchView.datasource = self
        searchView.customizeView()
        self.view.addSubview(searchView)

        statusBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        statusBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        statusBarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        statusBarView.heightAnchor.constraint(equalToConstant: 22.0).isActive = true
        
        searchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        searchView.topAnchor.constraint(equalTo: statusBarView.bottomAnchor).isActive = true
        searchView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
 
    func filters(in searchView: DMCSearchView) -> [DMCFilter] {

        let filter1 = DMCFilter(filterId: 1, filterName: "Monumentos")
        let filter2 = DMCFilter(filterId: 2, filterName: "Parques")
        let filter3 = DMCFilter(filterId: 3, filterName: "Iglesias")
        let filter4 = DMCFilter(filterId: 4, filterName: "Playas")
        let filter5 = DMCFilter(filterId: 5, filterName: "Curiosidades")
        let filter6 = DMCFilter(filterId: 6, filterName: "Gaitas")
        
        return [filter1, filter2, filter3, filter4, filter5, filter6]
    }
    
    func searchObjects(in searchView: DMCSearchView) -> [DMCSearchObject] {
        
        let searchObject1 = DMCSearchObject(searchObjectId: 1, searchObjectName: "Uno", searchObjectImageName: "casi")
        let searchObject2 = DMCSearchObject(searchObjectId: 2, searchObjectName: "Dos", searchObjectImageName: "casi")
        let searchObject3 = DMCSearchObject(searchObjectId: 3, searchObjectName: "Tres", searchObjectImageName: "casi")
        let searchObject4 = DMCSearchObject(searchObjectId: 4, searchObjectName: "Cuatro", searchObjectImageName: "casi")
        
        return [searchObject1, searchObject2, searchObject3, searchObject4]
    }
    
    func searchView(_ searchView: DMCSearchView, didSelectSearchObject searchObject: DMCSearchObject) {
        
        NSLog("Search Object pressed with name %@", searchObject.name)
    }
    
    func searchView(_ searchView: DMCSearchView, didSelectFilter filter: DMCFilter) {

        NSLog("Filter pressed with name %@", filter.name)
    }
    
}

