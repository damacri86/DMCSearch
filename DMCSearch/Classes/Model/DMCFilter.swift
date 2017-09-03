//
//  DMCFilter.swift
//  Pods
//
//  Created by David on 24/8/17.
//
//

import UIKit

open class DMCFilter: NSObject {

    public let id: Int
    public let name: String
    
    // MARK: Lifecycle
    public init(filterId id:Int, filterName name:String) {
        
        self.id = id
        self.name = name
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
