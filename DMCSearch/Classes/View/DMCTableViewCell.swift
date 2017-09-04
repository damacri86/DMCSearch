//
//  DMCTableViewCell.swift
//  Pods
//
//  Created by David on 4/9/17.
//
//

import UIKit

class DMCTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.imageView?.clipsToBounds = true
        self.imageView?.layer.cornerRadius = 10.0
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
