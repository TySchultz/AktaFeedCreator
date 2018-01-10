//
//  FeedItemCell.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 12/28/17.
//  Copyright © 2017 Ty Schultz. All rights reserved.
//

import UIKit
import FontAwesome_swift
class FeedItemCell: UICollectionViewCell {
    static let height: CGFloat = 60
    
    static func cellSize(width: CGFloat, text: String) -> CGSize {
        let labelBounds = TextSize.size(text, font:  HeadlineAppFont(), width: width - CommonInsets.left*2, insets: CommonInsets)
        return CGSize(width: width, height: labelBounds.height)
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkText
        label.font = HeadlineAppFont()
        label.textAlignment = .left
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        return label
    }()
    
//    lazy var upvoteButton: UIButton = {
//        let button = UIButton()
//        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
//        button.setTitle(String.fontAwesomeIcon(name: .bookmarkO), for: .normal)
//        button.setTitleColor(aktaPurple, for: .normal)
//        self.contentView.addSubview(button)
//        return button
//    }()
//
    
    lazy var cellNumberLabel: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        button.setTitle(String.fontAwesomeIcon(name: .bookmarkO), for: .normal)
        button.setTitleColor(aktaPurple, for: .normal)
        self.contentView.addSubview(button)
        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: CommonInsets.left, y: CommonInsets.top, width: bounds.width - CommonInsets.left*2, height: bounds.height - CommonInsets.top*2)
//        upvoteButton.frame = CGRect(x: bounds.width - CommonInsets.left*4, y: 0, width: CommonInsets.left*4, height: bounds.height - CommonInsets.top*2)
    }
}

