//
//  SectionHeaderObject.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/8/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
class SectionHeaderObject: NSObject {
    var title: String
    var subtitle: String

    //HeaderBased on date
    init(title : String, subtitle : String){
        self.title = title
        self.subtitle = subtitle
    }
}


extension SectionHeaderObject: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.title as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? SectionHeaderObject else { return false }
        return self.title == object.title && self.subtitle == object.subtitle
    }
}



