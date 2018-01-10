//
//  DoubleLineCell.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 12/30/17.
//  Copyright © 2017 Ty Schultz. All rights reserved.
//

import UIKit

class DoubleLineCell: UICollectionViewCell {
    static let height: CGFloat = 60
    
    static func cellSize(width: CGFloat, text: String) -> CGSize {
        let labelBounds = TextSize.size(text, font:  AppFont(size: 15), width: width - CommonInsets.left*2, insets: CommonInsets)
        return CGSize(width: width, height: labelBounds.height + CommonInsets.top*2 + 15)
    }
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkText
        label.font = AppFont(size: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var subTitle: UILabel = {
        let label = UILabel()
        label.textColor = aktaPurple
        label.font = AppFont(size: 13)
        label.textAlignment = .left
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = UIColor.white
        subTitle.frame = CGRect(x: CommonInsets.left, y: CommonInsets.top , width: bounds.width - CommonInsets.left*2, height: 15)
        title.frame = CGRect(x: CommonInsets.left, y: CommonInsets.top+15, width: bounds.width - CommonInsets.left*2, height: bounds.height - 15 - CommonInsets.top*4)
    }
}


