//
//  SettingsButtonListSectionController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/3/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import SwiftSH
import FontAwesome_swift
class SettingsButtonListSectionController: ListSectionController {
    private var item: StringOutput!
    var icon : FontAwesome = .compress
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
        cell.rightArrow.image = UIImage.fontAwesomeIcon(name: self.icon, textColor: aktaBlue, size: CGSize(width: 32, height: 32), backgroundColor: UIColor.clear)
        return cell
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is StringOutput)
        item = object as! StringOutput
    }
    
    override func didSelectItem(at index: Int) {
        if item.id == 0 {
            if let parent = self.viewController as? SettingsViewController {
                parent.downloadData()
            }
        }else if item.id == 1 {
            if let parent = self.viewController as? SettingsViewController {
                parent.organizeData()
            }
        }else {
            let shell = Shell(host: "45.55.145.57", port: 22)
            // ...
            shell?.withCallback { (string: String?, error: String?) in
                print("\(string ?? error!)")
                }
                .connect()
                .authenticate(.byPassword(username: "root", password: "Tyghbn77tyghbn77"))
                .open { (error) in
                    if let error = error {
                        print("\(error)")
                    }
            }
            // ...
            shell?.write("ls -lA") { (error) in
                if let error = error {
                    print("\(error)")
                }
            }
            // ...
            shell?.disconnect({
                print("disconnected")
            })
        }
    }
}
