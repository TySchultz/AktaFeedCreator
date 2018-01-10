//
//  FeedItemListSectionController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/2/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import SafariServices
import Alamofire
import AlamofireImage
class FeedItemListSectionController: ListSectionController {
    private var item: FeedItem!
    private var image: UIImage = #imageLiteral(resourceName: "MainScreenBackground")
    
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
            return DetailFeedItemCell.cellSize(width: collectionContext!.containerSize.width, text: item.title)
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
    
    func configureFeedItem(index : Int) -> DetailFeedItemCell {
        guard let cell =  collectionContext?.dequeueReusableCell(of: DetailFeedItemCell.self, for: self, at: index) as? DetailFeedItemCell
            else { fatalError() }
        cell.sourceImage.image = imageForSource(source: item.sourceName)
        cell.titleLabel.text = item.title
        cell.squareImage.image = self.image
        cell.contentView.backgroundColor = UIColor.white
        return cell
    }

    override func didUpdate(to object: Any) {
        precondition(object is FeedItem)
        item = object as! FeedItem
        downloadImage(link: item.imageLink)
    }
    
    func downloadImage(link : String) {
        Alamofire.request(link).responseImage { response in
            if let image = response.result.value {
                self.collectionContext?.performBatch(animated: true, updates: { (batchContext) in
                    self.image = image
                    batchContext.reload(self)
                })
            }
        }
    }
    
    override func didSelectItem(at index: Int) {
        
        
        let alertController = UIAlertController(title: "Remove Source?", message: item.title + "\n\n" + item.category, preferredStyle: .actionSheet)
        
        
        let  safariButton = UIAlertAction(title: "View In Safari", style: .default, handler: { (action) -> Void in
            let url = URL(string: self.item.link)!
            let safari = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            self.viewController?.present(safari, animated: true, completion: nil)
        })
        
        let  promoteButton = UIAlertAction(title: "Promote To Lead", style: .default, handler: { (action) -> Void in
            if let parent = self.viewController as? FeedCollectionDetailController {
                parent.promote(feedItem: self.item)
            }
        })
        
        let  deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            if let parent = self.viewController as? FeedCollectionDetailController {
                parent.removeItem(feedItem: self.item)
            }
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        })
        
        alertController.addAction(safariButton)
        alertController.addAction(promoteButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        viewController?.navigationController!.present(alertController, animated: true, completion: nil)
    }
}
