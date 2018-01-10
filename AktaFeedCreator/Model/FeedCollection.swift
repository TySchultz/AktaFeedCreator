//
//  FeedCollection.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 12/28/17.
//  Copyright © 2017 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit

class FeedCollection: NSObject {
    var articleTitle: String
    var mainSource: String
    var category: String
    let id: String
    var upVotes: Int
    var viewed: Bool

    var feedItems: [FeedItem]

    init(title : String, source :String, items : [FeedItem],id: String, category: String, upVotes: Int) {
        self.articleTitle = title
        self.mainSource = source
        self.feedItems = items
        self.id = id
        self.upVotes = upVotes
        self.category = category
        self.viewed = false
    }
    
    override init() {
        self.articleTitle = ""
        self.mainSource = ""
        self.feedItems = []
        self.id = "99999"
        self.upVotes = 0
        self.category = ""
        self.viewed = false
    }
}

extension FeedCollection: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? FeedCollection else { return false }
        return self.articleTitle == object.articleTitle && self.feedItems == object.feedItems && self.id == object.id && self.upVotes == upVotes
    }
}

