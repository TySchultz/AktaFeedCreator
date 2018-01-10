//
//  DetailFeedItemCell.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/2/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit

class DetailFeedItemCell: UICollectionViewCell {
    
    static let height: CGFloat = 60
    
    static func cellSize(width: CGFloat, text: String) -> CGSize {
        let labelBounds = TextSize.size(text, font:  AppFont(size: 15), width: width - DetailFeedItemCell.IMAGESIZE -  CommonInsets.left*4 - 32, insets: CommonInsets)
        if labelBounds.height + CommonInsets.top+20 < 100 {
            return CGSize(width: width, height: 80)
        }
        return CGSize(width: width, height: labelBounds.height + 20)
    }
    
    lazy var sourceImage: UIImageView = {
        let label = UIImageView()
        label.contentMode = .scaleAspectFit
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = BodyTextColor
        label.font = AppFont(size: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var rightArrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.fontAwesomeIcon(name: .timesCircle, textColor: aktaPurple, size: CGSize(width: 32, height: 32), backgroundColor: UIColor.clear)

        self.contentView.addSubview(image)
        return image
    }()
    
    lazy var squareImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8.0
        image.layer.masksToBounds = true
        
        self.contentView.addSubview(image)
        return image
    }()
    
    lazy var seperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.alpha = 1.0
        self.contentView.addSubview(view)
        return view
    }()
    
    static let IMAGESIZE :CGFloat = 64
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = UIColor.white
        let imageBox :CGFloat = DetailFeedItemCell.IMAGESIZE
        let textWidth :CGFloat = bounds.width - DetailFeedItemCell.IMAGESIZE -  CommonInsets.left*4 - 32
        squareImage.frame = CGRect(x: CommonInsets.left, y: CommonInsets.top, width: imageBox, height: imageBox)
        sourceImage.frame = CGRect(x: CommonInsets.left*2 + imageBox, y: 0, width: 133, height: 32)
        titleLabel.frame  = CGRect(x: CommonInsets.left*2 + imageBox, y: 20, width:  textWidth, height: bounds.height - 20)
        seperator.frame   = CGRect(x: CommonInsets.left*2 + imageBox, y: bounds.height - 1 , width: bounds.width - CommonInsets.left, height: 1)
        rightArrow.frame  = CGRect(x: bounds.width - 32 - CommonInsets.right, y: (bounds.height-32)/2, width: 32, height: 32)
    }
    
    func reset () {
        rightArrow.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.65, initialSpringVelocity: 3.0, options: .allowUserInteraction, animations: {
            self.rightArrow.transform = .identity
        }, completion: { (finished) in
        })
    }
}
