//
//  EditCollectionFieldCell.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/2/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit

class EditCollectionFieldCell: UICollectionViewCell {

    static let height: CGFloat = 60

    static func cellSize(width: CGFloat, text: String) -> CGSize {
        let labelBounds = TextSize.size(text, font:  HeadlineAppFont(), width: width - CommonInsets.left*4-64, insets: CommonInsets)
        var height:CGFloat = 60
        if labelBounds.height > height {
            height = labelBounds.height
        }
        return CGSize(width: width, height: height)
    }

    lazy var subTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = BoldAppFont(size: 12)
        label.textAlignment = .left
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        return label
    }()

    lazy var textField: UITextField = {
        let field = UITextField()
        field.textColor = BodyTextColor
        field.font = HeadlineAppFont()
        field.textAlignment = .left
        field.returnKeyType = .done
        self.contentView.addSubview(field)
        return field
    }()

    lazy var seperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.alpha = 1.0
        self.contentView.addSubview(view)
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = UIColor.white
        subTitle.frame  = CGRect(x: CommonInsets.left, y: 15, width: bounds.width - CommonInsets.left*2, height: 15)
        textField.frame = CGRect(x: CommonInsets.left, y: 30, width: bounds.width - CommonInsets.left*2, height: bounds.height - 15 - CommonInsets.top*2)
        seperator.frame  = CGRect(x: CommonInsets.left, y: bounds.height - 1 , width: bounds.width - CommonInsets.left, height: 1)
    }
}
