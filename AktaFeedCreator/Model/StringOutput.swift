//
//  StringOutput.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/2/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
class StringOutput: NSObject {
    var text: String
    var id : Int
    //HeaderBased on date
    init(text : String, id : Int){
       self.text = text
        self.id = id
    }
}


extension StringOutput: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? StringOutput else { return false }
        return self.text == object.text && self.id == object.id
    }
}


