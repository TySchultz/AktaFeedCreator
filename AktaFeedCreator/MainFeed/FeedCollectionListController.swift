//
//  FeedCollectionListController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 12/28/17.
//  Copyright © 2017 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import SafariServices
import FontAwesome_swift
import AlamofireImage
import Alamofire
class FeedCollectionListController: ListSectionController {

    private var collection: FeedCollection!
    private var backgroundColor : UIColor = .white
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    override func numberOfItems() -> Int {
        return 3
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext!.containerSize.width
        switch index {
//        case 5:
//            return FeedItemImageCell.cellSize(width: collectionContext!.containerSize.width, image: self.image)
//            return CGSize(width: width, height: 0)
        case 0:
            return FeedItemCell.cellSize(width: width, text: collection.articleTitle)
        case 1:
            return CGSize(width: width, height: FeedItemCellStats.height)
        case 2:
            return CGSize(width: width, height: 32)
        default:
            return CGSize.zero
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
//        case 5:
//            return configureImage(index:index)
        case 0:
            return configureTitle(index:index)
        case 1:
            return configureStatsCell(index:index)
        case 2:
            return configureSeperator(index:index)
        default:
            return configureSeperator(index:index)
        }
    }
    
//    func configureImage(index: Int) -> FeedItemImageCell {
//        guard let cell =  collectionContext?.dequeueReusableCell(of: FeedItemImageCell.self, for: self, at: index) as? FeedItemImageCell
//            else { fatalError() }
//        cell.image.image = self.image
////        cell.contentView.backgroundColor = self.backgroundColor
//        return cell
//    }
    
    func configureTitle(index : Int) -> FeedItemCell {
        guard let cell =  collectionContext?.dequeueReusableCell(of: FeedItemCell.self, for: self, at: index) as? FeedItemCell
            else { fatalError() }
        cell.titleLabel.text = collection.articleTitle
        cell.backgroundColor = self.backgroundColor
        return cell
    }

    func configureStatsCell(index: Int) ->FeedItemCellStats {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "FeedItemCellStats", bundle: nil, for: self, at: index) as? FeedItemCellStats else { fatalError() }
        cell.upvotesLabel.text = String(collection.upVotes)
        cell.categoryLabel.text = collection.category
        cell.numberOfArticlesLabel.text = String(collection.feedItems.count)

        var count = 0
        var thirdSource = ""
        for (index, item) in collection.feedItems.enumerated() {
            switch index {
            case 0:
                cell.sourceOne.text = item.sourceName + ","
            case 1:
                cell.sourceTwo.text = item.sourceName + ","
            case 2:
                cell.sourceThree.text = item.sourceName
                thirdSource = item.sourceName
            default:
                count += 1
            }
        }
        if count > 0 {
            cell.sourceThree.text = thirdSource + ","
            cell.sourceFour.text = "+" + String(count) + " more"
        }else {
            cell.sourceFour.text = ""
        }
        cell.backgroundColor = self.backgroundColor

        return cell
    }
//
    func configureSeperator(index: Int) -> SeperatorCell {
        guard let cell =  collectionContext?.dequeueReusableCell(of: SeperatorCell.self, for: self, at: index) as? SeperatorCell
            else { fatalError() }
        cell.seperator.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = self.backgroundColor
        return cell
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is FeedCollection)
        collection = object as! FeedCollection
    }
//
//    func downloadImage() {
//        var link = ""
//        for item in collection.feedItems {
//            if item.imageLink != "" {
//                link = item.imageLink
//                break
//            }
//        }
//        Alamofire.request(link).responseImage { response in
//            if let image = response.result.value {
//                self.image = image
//                self.collectionContext?.performBatch(animated: true, updates: { (batchContext) in
//                    batchContext.reload(self)
//                })
//            }
//        }
//    }
    
    override func didSelectItem(at index: Int) {
        self.backgroundColor = aktaPurple.withAlphaComponent(0.1)
        self.collectionContext?.performBatch(animated: true, updates: { (batchContext) in
            batchContext.reload(self)
        })
        let detailController = FeedCollectionDetailController()
        detailController.feedCollection = collection
        viewController?.navigationController?.pushViewController(detailController, animated: true)
    }
}

