//
//  DMCSearchObject.swift
//  Pods
//
//  Created by David on 25/8/17.
//
//

import UIKit

open class DMCSearchObject: NSObject {

    public let id: Int
    public let name: String
    public let imageName: String
    
    // MARK: Lifecycle
    public init(searchObjectId id:Int, searchObjectName name:String, searchObjectImageName imageName:String) {
        
        self.id = id
        self.name = name
        self.imageName = imageName
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
