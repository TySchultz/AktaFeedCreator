//
//  FeedItemCellStats.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/2/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit

class FeedItemCellStats: UICollectionViewCell {
    
    static let height :CGFloat = 40
    
    @IBOutlet weak var upvotesLabel: UILabel!
    @IBOutlet weak var faHeart: UILabel!
    @IBOutlet weak var faGlobe: UILabel!
    @IBOutlet weak var numberOfArticlesLabel: UILabel!
    @IBOutlet weak var faBookmark: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var stack: UIStackView!
    
    @IBOutlet weak var sourceOne: UILabel!
    @IBOutlet weak var sourceTwo: UILabel!
    @IBOutlet weak var sourceThree: UILabel!
    @IBOutlet weak var sourceFour: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor     = UIColor.clear
        self.faBookmark.textColor            = UIColor.lightGray
        self.categoryLabel.textColor         = UIColor.lightGray
        self.numberOfArticlesLabel.textColor = UIColor.lightGray
        self.faGlobe.textColor               = UIColor.lightGray
        self.faHeart.textColor               = UIColor.lightGray
        self.upvotesLabel.textColor          = UIColor.lightGray
       
        self.sourceOne.textColor   = UIColor.lightGray
        self.sourceTwo.textColor   = UIColor.lightGray
        self.sourceThree.textColor = UIColor.lightGray
        self.sourceFour.textColor  = UIColor.lightGray

        self.faBookmark.font = UIFont.fontAwesome(ofSize: 13)
        self.faBookmark.text = String.fontAwesomeIcon(name: .book)
        self.faGlobe.font = UIFont.fontAwesome(ofSize: 13)
        self.faGlobe.text = String.fontAwesomeIcon(name: .globe)
        self.faHeart.font = UIFont.fontAwesome(ofSize: 13)
        self.faHeart.text = String.fontAwesomeIcon(name: .bookmark)
    }
}
