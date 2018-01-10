//
//  FeedbackFieldCell.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/8/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit

class FeedbackFieldCell: UICollectionViewCell {
    static let height: CGFloat = 60
    
    lazy var textField: UITextField = {
        let field = UITextField()
        let leftView = UIView(frame:CGRect(x: 0, y: 0, width: 16, height: FeedbackFieldCell.height))
        leftView.backgroundColor = UIColor.clear
        field.leftView = leftView
        field.leftViewMode = UITextFieldViewMode.always
        field.textColor = BodyTextColor
        field.font = AppFont()
        field.placeholder = "Submit source"
        field.textAlignment = .left
        field.returnKeyType = .done
        field.layer.cornerRadius = 8.0
        field.layer.borderWidth = 0.0
        field.backgroundColor = UIColor.groupTableViewBackground
        self.contentView.addSubview(field)
        return field
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = UIColor.white
        textField.frame = CGRect(x: CommonInsets.left, y: CommonInsets.top, width: bounds.width - CommonInsets.left*2, height: bounds.height - CommonInsets.top*2)
    }
    
    func animateSuccess() {
       
    
    }
}
