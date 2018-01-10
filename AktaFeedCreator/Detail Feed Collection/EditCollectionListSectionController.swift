//
//  EditCollectionListSectionController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/2/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit

class EditCollectionListSectionController: ListSectionController, UITextFieldDelegate {

    private var collection: FeedCollection!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    override func numberOfItems() -> Int {
        return 4
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        switch index {
        case 0:
            return CGSize(width: collectionContext!.containerSize.width, height: 64)
        default:
            return CGSize(width: collectionContext!.containerSize.width, height: 64)
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
    
    func configureFeedItem(index : Int) -> EditCollectionFieldCell {
        guard let cell =  collectionContext?.dequeueReusableCell(of: EditCollectionFieldCell.self, for: self, at: index) as? EditCollectionFieldCell
            else { fatalError() }
        switch index {
        case 0:
            cell.subTitle.text = "Title"
            cell.textField.text = collection.articleTitle
            break
        case 1:
            cell.subTitle.text = "MainSource"
            cell.textField.text = collection.mainSource
            break
        case 2:
            cell.subTitle.text = "Upvotes"
            cell.textField.text = String(collection.upVotes)
            break
        case 3:
            cell.subTitle.text = "Category"
            cell.textField.text = collection.category
            break
        default:
            break
        }
        cell.textField.tag = index
        cell.textField.delegate = self
        return cell
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is FeedCollection)
        collection = object as! FeedCollection
    }
    
    override func didSelectItem(at index: Int) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        switch textField.tag {
        case 0:
            self.collection.articleTitle = text
            break
        case 1:
            self.collection.mainSource = text
            break
        case 2:
            if let num = Int(text) {
                self.collection.upVotes = num
            }
            break
        case 3:
            self.collection.category = text
            break
        default:
            break
        }
        textField.resignFirstResponder()
        if let parent = self.viewController as? FeedCollectionDetailController {
            parent.upload()
        }
        return true
    }
}

