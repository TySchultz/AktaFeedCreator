//
//  SourceDetailLIstController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/5/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import SafariServices
import Alamofire
import AlamofireImage
class SourceDetailListController: ListSectionController {
    private var collection: SourceCollection!
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    override func numberOfItems() -> Int {
        return collection.feedItems.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let feed = collection.feedItems[index]
        switch index {
        case 0,7,14:
            return DoubleLineCell.cellSize(width: (collectionContext?.containerSize.width)!, text: feed.title)
        default:
            return DoubleLineCell.cellSize(width: (collectionContext?.containerSize.width)!/2, text: feed.title)
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
    
    func configureFeedItem(index : Int) -> DoubleLineCell {
        guard let cell =  collectionContext?.dequeueReusableCell(of: DoubleLineCell.self, for: self, at: index) as? DoubleLineCell
            else { fatalError() }
        let feed = collection.feedItems[index]
        cell.title.text = feed.title
        cell.subTitle.text = feed.author
        cell.contentView.backgroundColor = UIColor.white
        return cell
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is SourceCollection)
        collection = object as! SourceCollection
    }
    
    override func didSelectItem(at index: Int) {
        let feed = collection.feedItems[index]
        let url = URL(string: feed.link)!
        let safari = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        self.viewController?.present(safari, animated: true, completion: nil)
    }
}
