//
//  Theme.swift
//  Akta
//
//  Created by Ty Schultz on 11/8/17.
//  Copyright © 2017 Ty Schultz. All rights reserved.
//

import UIKit

extension UIColor {
    // https://github.com/yeahdongcn/UIColor-Hex-Swift/blob/master/HEXColor/UIColorExtension.swift
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

let NormalTextColor = UIColor.black
let BodyTextColor = UIColor.darkGray
let CommonInsets  = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
let BodyInsets    = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
let QuoteInsets   = UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 32)
let QuizCardInsets   = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

let aktaBlue = UIColor(hex6: 0x19BEFD)
let aktaPurple = UIColor(hex6: 0x9564F3)
let aktaGreen = UIColor(hex6: 0x40CF8F)
let aktaRed = UIColor(hex6: 0xE6079D)
let aktaYellow = UIColor(hex6: 0xFEC86D)
let aktaQuizCardBackgroundColor = UIColor(hex6: 0x413B9F)

func AppFont(size: CGFloat = 17) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: .regular)
}

func HeadlineAppFont(size: CGFloat = 18) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: .semibold)
}

func SectionHeaderFont(size: CGFloat = 18) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: .heavy)
}

func SubTitleFont(size: CGFloat = 13) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: .medium)
}

func StatusFont(size: CGFloat = 12) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: .regular)
}

func BoldAppFont(size: CGFloat = 17) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}

func HeavyAppFont(size: CGFloat = 17) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: .heavy)
}

func imageForSource(source:String) -> UIImage {
    let item = rssFeeds.filter { (feed) -> Bool in
        return feed.name == source
    }

    if let first = item.first {
         return first.image
    }
    return #imageLiteral(resourceName: "emptySourceLogo")
}




