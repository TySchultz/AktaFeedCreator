//
//  DeleteCollectionListSectionController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/3/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit

class DeleteCollectionListSectionController: ListSectionController {
    private var item: StringOutput!
    
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
        return CGSize(width: collectionContext!.containerSize.width, height: 64)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        return configureFeedItem(index:index)
    }
    
    func configureFeedItem(index : Int) -> SingleButtonCell {
        guard let cell =  collectionContext?.dequeueReusableCell(of: SingleButtonCell.self, for: self, at: index) as? SingleButtonCell
            else { fatalError() }
        cell.title.text = item.text
        cell.title.backgroundColor = aktaRed.withAlphaComponent(0.15)
        return cell
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is StringOutput)
        item = object as! StringOutput
    }
    
    override func didSelectItem(at index: Int) {
        if let parent = self.viewController as? FeedCollectionDetailController {
            parent.deleteCollection()
        }
    }
}

