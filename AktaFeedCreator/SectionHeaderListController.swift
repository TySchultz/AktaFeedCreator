//
//  SectionHeaderListController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/8/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
class SectionHeaderListController: ListSectionController {
    private var item: SectionHeaderObject!
    
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
        switch index {
        case 0:
            return CGSize(width: collectionContext!.containerSize.width, height: SectionHeaderCell.height)
        default:
            return CGSize.zero
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        switch index {
        case 0:
            return configureFeedItem(index:index)
        default:
            return configureFeedItem(index:index)
        }
    }
    
    func configureFeedItem(index : Int) -> SectionHeaderCell {
        guard let cell =  collectionContext?.dequeueReusableCell(of: SectionHeaderCell.self, for: self, at: index) as? SectionHeaderCell
            else { fatalError() }
        cell.title.text = item.title.uppercased()
        cell.subtitle.text = item.subtitle
        cell.contentView.backgroundColor = UIColor.white
        return cell
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is SectionHeaderObject)
        item = object as! SectionHeaderObject
    }
    
    override func didSelectItem(at index: Int) {
        
    }
}

