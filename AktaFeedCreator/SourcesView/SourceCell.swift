//
//  SourceCell.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/5/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit

class SourceCell: UICollectionViewCell {
    static let height: CGFloat = 60
    
    static func cellSize(width: CGFloat, text: String) -> CGSize {
        let labelBounds = TextSize.size(text, font:  HeadlineAppFont(), width: width - CommonInsets.left*4-64, insets: CommonInsets)
        return CGSize(width: labelBounds.width, height: 45)
    }
    
    lazy var titleImage: UIImageView = {
        let label = UIImageView()
        label.contentMode = .scaleAspectFill
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = HeadlineAppFont()
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var rightArrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.fontAwesomeIcon(name: .arrowCircleRight, textColor: UIColor.darkGray.withAlphaComponent(0.2), size: CGSize(width: 32, height: 32), backgroundColor: UIColor.clear)
        self.contentView.addSubview(image)
        return image
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = UIColor.white
        titleImage.frame = CGRect(x: CommonInsets.left, y: 0, width: (bounds.width/3)*2, height: bounds.height)
        title.frame = CGRect(x: CommonInsets.left, y: 0, width: (bounds.width/3)*2, height: bounds.height)
        rightArrow.frame  = CGRect(x: bounds.width - 32 - CommonInsets.right, y: (bounds.height-32)/2, width: 32, height: 32)
        contentView.sendSubview(toBack: title)
    }
}
