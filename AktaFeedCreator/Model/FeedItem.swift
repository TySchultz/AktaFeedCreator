//
//  FeedItem.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 12/28/17.
//  Copyright © 2017 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit

class FeedItem: NSObject {
    var id : String
    let title: String
    let sourceName: String
    let link: String
    let author: String
    let category: String
    let imageLink: String
    let articleDescription: String

    init(id: String, title : String, source : String, link : String, author : String, category : String, imageLink : String, articleDescription : String) {
        self.id = id
        self.title = title
        self.sourceName = source
        self.link = link
        self.author = author
        self.category = category
        self.imageLink = imageLink
        self.articleDescription = articleDescription
    }
}

extension FeedItem: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? FeedItem else { return false }
        return self.title == object.title && self.sourceName == object.sourceName && self.link == object.link && self.id == object.id && self.category == object.category && self.author == object.author
    }
}


