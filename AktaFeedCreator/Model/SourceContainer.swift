//
//  SourceContainer.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/5/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
class SourceContainer: NSObject {
    let id: String
    var sources: [SourceCollection]
    
    init(items : [SourceCollection],id: String) {
        self.sources = items
        self.id = id
    }
}

extension SourceContainer: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? SourceContainer else { return false }
        return self.sources == object.sources && self.id == object.id
    }
}



