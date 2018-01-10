//
//  SectionHeaderCell.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/8/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit

class SectionHeaderCell: UICollectionViewCell {
    static let height: CGFloat = CommonInsets.top*4 + 50
    
    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = SubTitleFont()
        label.textColor = UIColor.darkGray
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = SectionHeaderFont()
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var seperator: UIView = {
        let label = UIView()
        label.backgroundColor = UIColor.groupTableViewBackground
        self.contentView.addSubview(label)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = UIColor.white
        seperator.frame = CGRect(x: CommonInsets.left, y: 0, width: bounds.width-CommonInsets.left*2, height: 1)
        title.frame    = CGRect(x: CommonInsets.left, y: CommonInsets.top, width: bounds.width, height: 30)
        subtitle.frame = CGRect(x: CommonInsets.left, y: CommonInsets.top + 30, width: bounds.width, height: 20)
    }
}


