//
//  SeperatorCell.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/2/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit

class SeperatorCell: UICollectionViewCell {
    
    static func cellSize(width: CGFloat) -> CGSize {
        return CGSize(width: width, height: 1)
    }
    
    lazy var seperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.alpha = 1.0
        self.contentView.addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = UIColor.clear
        seperator.frame  = CGRect(x: CommonInsets.left, y: bounds.height - 1, width: bounds.width - CommonInsets.left, height: 1)
    }
}


