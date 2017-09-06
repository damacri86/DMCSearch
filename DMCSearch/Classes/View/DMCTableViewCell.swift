//
//  DMCTableViewCell.swift
//  Pods
//
//  Created by David on 4/9/17.
//
//

import UIKit

class DMCTableViewCell: UITableViewCell {
    
    public var cellImageView: UIImageView?
    public var cellTitleLabel: UILabel?
    public var cellTextLabel: UILabel?
    
    let imageMargin: CGFloat = 10.0
    
    // MARK: Lifecylce
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.customizeView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Public
    static func cellHeight() -> CGFloat {
        
        return 120.0
    }
    
    // Private
    func customizeView() {
        
        self.cellImageView = UIImageView(frame: CGRect(x: imageMargin,
                                                       y: imageMargin,
                                                       width: DMCTableViewCell.cellHeight() - 2 * imageMargin,
                                                       height: DMCTableViewCell.cellHeight() - 2 * imageMargin))
        self.cellImageView?.contentMode = .scaleAspectFill
        self.addSubview(self.cellImageView!)
        
        self.cellTitleLabel = UILabel(frame: CGRect(x: 5 + (self.cellImageView?.frame.size.width)! + 2 * imageMargin,
                                                    y: 20,
                                                    width: self.bounds.size.width - 2 * imageMargin - (self.cellImageView?.frame.size.width)! - 10,
                                                    height: 20))
        self.cellTitleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        self.cellTitleLabel?.numberOfLines = 0
        self.addSubview(self.cellTitleLabel!)
        
        self.cellTextLabel = UILabel(frame: CGRect(x: 5 + (self.cellImageView?.frame.size.width)! + 2 * imageMargin,
                                                   y: 20 + 20 + 5,
                                                   width: self.bounds.size.width - 2 * imageMargin - (self.cellImageView?.frame.size.width)! - 10,
                                                   height: 60))
        self.cellTextLabel?.font = UIFont.systemFont(ofSize: 13.0)
        self.cellTextLabel?.numberOfLines = 0
        self.addSubview(self.cellTextLabel!)
    }
    
    override func layoutSubviews() {
        
        self.cellImageView?.frame = CGRect(x: imageMargin,
                                           y: imageMargin,
                                           width: DMCTableViewCell.cellHeight() - 2 * imageMargin,
                                           height: DMCTableViewCell.cellHeight() - 2 * imageMargin)
        
        self.cellTitleLabel?.frame = CGRect(x: 5 + (self.cellImageView?.frame.size.width)! + 2 * imageMargin,
                                            y: 20,
                                            width: self.bounds.size.width - 2 * imageMargin - (self.cellImageView?.frame.size.width)! - 20,
                                            height: 20)
        
        self.cellTextLabel?.frame = CGRect(x: 5 + (self.cellImageView?.frame.size.width)! + 2 * imageMargin,
                                           y: 20 + 20 + 5,
                                           width: self.bounds.size.width - 2 * imageMargin - (self.cellImageView?.frame.size.width)! - 20,
                                           height: 60)
    }
}
