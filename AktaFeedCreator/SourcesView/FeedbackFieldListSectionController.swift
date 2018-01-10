//
//  FeedbackFieldListSectionController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/8/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import StatusAlert

class FeedbackFieldListSectionController: ListSectionController, UITextFieldDelegate{
    private var item: String!
    
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
        switch index {
        case 0:
            return CGSize(width: collectionContext!.containerSize.width, height:SectionHeaderCell.height)
        case 1:
            return CGSize(width: collectionContext!.containerSize.width, height:FeedbackFieldCell.height)
        case 2:
            return CGSize(width: collectionContext!.containerSize.width, height:32)
        default:
            return CGSize.zero
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            return configureSectionHeader(index:index)
        case 1:
            return configureFieldCel(index:index)
        case 2:
            return configureSpacer(index:index)
        default:
            return configureSpacer(index:index)
        }
    }
    
    func configureFieldCel(index : Int) -> FeedbackFieldCell {
        guard let cell =  collectionContext?.dequeueReusableCell(of: FeedbackFieldCell.self, for: self, at: index) as? FeedbackFieldCell
            else { fatalError() }
        cell.textField.placeholder = "Submit"
        cell.textField.text = ""
        cell.textField.delegate = self
        cell.contentView.backgroundColor = UIColor.white
       
        let leftView = UIView(frame:CGRect(x: 0, y: 0, width: 16, height: FeedbackFieldCell.height))
        leftView.backgroundColor = UIColor.clear
        cell.textField.leftView = leftView
        return cell
    }
    
    func configureSectionHeader(index : Int) -> SectionHeaderCell {
        guard let cell =  collectionContext?.dequeueReusableCell(of: SectionHeaderCell.self, for: self, at: index) as? SectionHeaderCell
            else { fatalError() }
        cell.title.text = "SUBMIT YOUR OWN"
        cell.subtitle.text = "More sources, more accurate news"
        return cell
    }
    
    func configureSpacer(index : Int) -> SeperatorCell {
        guard let cell =  collectionContext?.dequeueReusableCell(of: SeperatorCell.self, for: self, at: index) as? SeperatorCell
            else { fatalError() }
        cell.seperator.backgroundColor = UIColor.clear
        return cell
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is String)
        item = object as! String
    }
    
    override func didSelectItem(at index: Int) {
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            textField.resignFirstResponder()
            return true
        }
        textField.resignFirstResponder()
        let image = UIImageView()
        image.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        image.image = UIImage.fontAwesomeIcon(name: .checkCircleO, textColor: aktaGreen, size: CGSize(width: 32, height: 32), backgroundColor: UIColor.clear)
        UIView.animate(withDuration: 0.3, delay: 1.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: {
            textField.leftView = image
            textField.placeholder = "Submitted"
            textField.text = ""
        }) { (complete) in
            let d = Downloader()
            d.uploadSuggestion(sourceSuggestion: text)
            print(text)
        }
        
        // Creating StatusAlert instance
        let faImage = UIImage.fontAwesomeIcon(name: .checkCircleO, textColor: aktaGreen.withAlphaComponent(0.7), size: CGSize(width: 50, height: 50), backgroundColor: UIColor.clear)
        let statusAlert = StatusAlert.instantiate(withImage: faImage,
                                                  title: "Thank you!",
                                                  message: "We will find the magic that is needed to integrate in the feed.",
                                                  canBePickedOrDismissed: true)
        // Presenting created instance
        statusAlert.showInKeyWindow()
        return true
    }
    
}

