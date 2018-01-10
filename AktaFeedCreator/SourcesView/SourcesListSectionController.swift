//
//  SourcesListSectionController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/5/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
class SourcesListSectionController: ListSectionController {
    private var feed: Feed!
    
    
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
        var width = collectionContext!.containerSize.width
        if width > 400 {
            width = collectionContext!.containerSize.width/2
        }
        return CGSize(width: width, height: SourceCell.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            return configureFeedItem(index:index)
        default:
            return configureFeedItem(index:index)
        }
    }
    
    func configureFeedItem(index : Int) -> SourceCell {
        guard let cell =  collectionContext?.dequeueReusableCell(of: SourceCell.self, for: self, at: index) as? SourceCell
            else { fatalError() }
        cell.titleImage.image = feed.image
        cell.title.text       = feed.name
        cell.contentView.backgroundColor = UIColor.white
        return cell
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is Feed)
        feed = object as! Feed
    }
    
    override func didSelectItem(at index: Int) {
        let feedDetails = SourceFeedViewController()
        feedDetails.feed = self.feed
        viewController?.navigationController?.pushViewController(feedDetails, animated: true)
    }
}

