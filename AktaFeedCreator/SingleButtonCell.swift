//
//  SingleButtonCell.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/3/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit

class SingleButtonCell: UICollectionViewCell {
    static let height: CGFloat = 60
    
    static func cellSize(width: CGFloat, text: String) -> CGSize {
        let labelBounds = TextSize.size(text, font:  AppFont(size: 15), width: width - CommonInsets.left*4-64, insets: CommonInsets)
        return CGSize(width: width, height: 45)
    }
    
    lazy var title: TSLabel = {
        let label = TSLabel()
        label.textColor = UIColor.darkText
        label.font = AppFont()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.backgroundColor = UIColor.groupTableViewBackground
        label.layer.cornerRadius = 8.0
        label.layer.masksToBounds = true
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var rightArrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.fontAwesomeIcon(name: .ban, textColor: aktaRed, size: CGSize(width: 32, height: 32), backgroundColor: UIColor.clear)
        self.contentView.addSubview(image)
        return image
    }()
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title.frame = CGRect(x: CommonInsets.left, y: CommonInsets.top, width: bounds.width - CommonInsets.left*2, height: bounds.height-CommonInsets.top*2)
        rightArrow.frame  = CGRect(x: bounds.width - 32 - CommonInsets.right*2, y: (bounds.height-32)/2, width: 32, height: 32)
    }
}

class TSLabel : UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 8)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}


