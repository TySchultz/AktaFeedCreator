//
//  Feed.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/5/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
class Feed: NSObject {
    let id : Int
    let name: String
    let link: String
    let image: UIImage
    
    init(id: Int, name : String, link : String, image : UIImage ) {
        self.id = id
        self.name = name
        self.link = link
        self.image = image
    }
}

extension Feed: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? Feed else { return false }
        return self.name == object.name && self.link == object.link && self.image == object.image
    }
}



