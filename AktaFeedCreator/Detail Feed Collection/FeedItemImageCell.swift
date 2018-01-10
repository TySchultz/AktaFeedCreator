//
//  FeedItemImageCell.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/3/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit

class FeedItemImageCell: UICollectionViewCell {
    static let height: CGFloat = 60
    
    static func cellSize(width: CGFloat, image : UIImage) -> CGSize {
        let imageHeight = image.size.height
        let imageWidth = image.size.width-CommonInsets.left*2
        var height:CGFloat = 0
        height =  imageHeight * (width/imageWidth)
        height =  height + CommonInsets.left*2
        return CGSize(width: width, height: height)
    }
  
    lazy var image: UIImageView = {
        let label = UIImageView()
        label.contentMode = .scaleAspectFit
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4.0
        self.contentView.addSubview(label)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = UIColor.white
        image.frame  = CGRect(x: CommonInsets.left, y: CommonInsets.left, width: bounds.width-CommonInsets.left*2, height: bounds.height-CommonInsets.left*2)
        image.center = contentView.center
    }
}


