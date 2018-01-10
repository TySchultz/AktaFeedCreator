//
//  ImageCellListSectionController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/3/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import Alamofire
import AlamofireImage
class ImageCellListSectionController: ListSectionController {
    
    private var collection: FeedCollection!
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
            return CGSize(width: collectionContext!.containerSize.width, height: 300)
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
    
    func configureFeedItem(index : Int) -> FeedItemImageCell {
        guard let cell =  collectionContext?.dequeueReusableCell(of: FeedItemImageCell.self, for: self, at: index) as? FeedItemImageCell
            else { fatalError() }
        cell.image.image = self.image
        return cell
    }
    
    func downloadImage() {
        guard let url = self.collection.feedItems.first?.link else { return }
        Alamofire.request(url).responseString { response in
//            if let doc = HTML(html: response.result.value!, encoding: .utf8) {
//                // Search for nodes by XPath
//                for link in doc.xpath("//meta") {
//                    if let property = link["property"] {
//                        let content = link["content"] ?? ""
//                        switch property {
//                        case "og:image":
//                            self.linkImageField.stringValue = content
//                            self.downloadImage(link: content)
//                            break
//                        default:
//                            break
//                        }
//                    }
//                }
//            }
        }
    }
    
    func downloadImage(link : String) {
        Alamofire.request(link).responseImage { response in
            if let image = response.result.value {
                self.image = image
                self.collectionContext?.performBatch(animated: true, updates: { (batchContext) in
                    batchContext.reload(self)
                })

            }
        }
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is FeedCollection)
        collection = object as! FeedCollection
//        downloadImage()
    }
    
    override func didSelectItem(at index: Int) {
        
    }
}
