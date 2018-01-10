//
//  SourceCollection.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/5/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit

class SourceCollection: NSObject {
    var mainSource: String
    let id: String
    var feedItems: [FeedItem]
    
    init(source :String, items : [FeedItem],id: String) {
        self.mainSource = source
        self.feedItems = items
        self.id = id
    }
}

extension SourceCollection: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? SourceCollection else { return false }
        return self.feedItems == object.feedItems && self.id == object.id && self.mainSource == object.mainSource
    }
}


