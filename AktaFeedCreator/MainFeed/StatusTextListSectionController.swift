//
//  StatusTextListSectionController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit

class StatusTextCell: UICollectionViewCell {
    static let height: CGFloat = 20
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkText
        label.font = StatusFont()
        label.textAlignment = .left
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: CommonInsets.left, y: CommonInsets.top, width: bounds.width - CommonInsets.left*2, height: bounds.height)
    }
}

class StatusTextListSectionController: ListSectionController {

    private var item: String!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: StatusTextCell.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        return configureText(index:index)
    }
    
    func configureText(index : Int) -> StatusTextCell {
        guard let cell =  collectionContext?.dequeueReusableCell(of: StatusTextCell.self, for: self, at: index) as? StatusTextCell
            else { fatalError() }
        cell.titleLabel.text = item
        return cell
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is String)
        item = object as! String
    }
    
 
    
    override func didSelectItem(at index: Int) {
        
    }
}

