//
//  SingleLineCell.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 12/30/17.
//  Copyright © 2017 Ty Schultz. All rights reserved.
//

import UIKit

class SingleLineCell: UICollectionViewCell {
    static let height: CGFloat = 60
    
    static func cellSize(width: CGFloat, text: String) -> CGSize {
        let labelBounds = TextSize.size(text, font:  AppFont(size: 15), width: width - CommonInsets.left*4-64, insets: CommonInsets)
        return CGSize(width: width, height: 45)
    }
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkText
        label.font = BoldAppFont(size: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = UIColor.white
        title.frame = CGRect(x: CommonInsets.left*2, y: 0, width: bounds.width - CommonInsets.left*4, height: bounds.height)
    }
}

