//
//  Strings.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 12/28/17.
//  Copyright © 2017 Ty Schultz. All rights reserved.
//

import UIKit

let rssFeeds : [Feed] = [
    //Rss feeds
    Feed(id: 2, name: "NYTimes",        link: "https://flipboard.com/@newyorktimes.rss", image: #imageLiteral(resourceName: "NYTimes")),
//    Feed(id: 12, name: "CBS",           link: "https://www.cbsnews.com/latest/rss/main", image: #imageLiteral(resourceName: "XButton")),
    Feed(id: 13, name: "ABC",           link: "https://flipboard.com/@abc.rss", image: #imageLiteral(resourceName: "ABC")),
    Feed(id: 17, name: "The Guardian",  link: "https://flipboard.com/@TheGuardian.rss", image: #imageLiteral(resourceName: "theguardian")),
    Feed(id: 24, name: "BBC",           link: "https://flipboard.com/@BBCNews.rss", image:  #imageLiteral(resourceName: "BBC")),
    Feed(id: 19, name: "The Verge",     link: "https://flipboard.com/@theverge.rss", image:  #imageLiteral(resourceName: "TheVerge")),
    Feed(id: 25, name: "Economist",     link: "https://flipboard.com/@TheEconomist.rss", image:  #imageLiteral(resourceName: "TheEconomist")),
    Feed(id: 29, name: "Politico",      link: "https://flipboard.com/@politico.rss", image:  #imageLiteral(resourceName: "Politico")),
    Feed(id: 0, name: "NPR",            link: "https://flipboard.com/@npr.rss", image:  #imageLiteral(resourceName: "NPR")),
    Feed(id: 1, name: "CNN",            link: "https://flipboard.com/@CNN.rss", image:  #imageLiteral(resourceName: "CNN")),
    Feed(id: 11, name: "CNBC",          link: "https://flipboard.com/@CNBC.rss", image:  #imageLiteral(resourceName: "CNBC")),
    Feed(id: 3, name: "Reuters",        link: "https://flipboard.com/@Reuters.rss", image:  #imageLiteral(resourceName: "Reuters")),
    Feed(id: 6, name: "ars technica",   link: "https://flipboard.com/@ArsTechnica.rss", image: #imageLiteral(resourceName: "Ars")),
    Feed(id: 8, name: "TechCrunch",     link: "https://flipboard.com/@TechCrunch.rss", image: #imageLiteral(resourceName: "TechCrunch")),
    Feed(id: 9, name: "Time",           link: "https://flipboard.com/@time.rss", image: #imageLiteral(resourceName: "Time")),
    Feed(id: 10, name: "Fox",           link: "https://flipboard.com/@FoxNews.rss", image: #imageLiteral(resourceName: "Fox")),
    Feed(id: 14, name: "LA Times",      link: "https://flipboard.com/@LATimes.rss", image: #imageLiteral(resourceName: "LATimes")),
    Feed(id: 15, name: "PBS",           link: "https://flipboard.com/@frontlinepbs.rss", image: #imageLiteral(resourceName: "PBS")),
    Feed(id: 16, name: "WSJ",           link: "https://flipboard.com/section/the-wall-street-journal.-8be5a2an3cqu4t8e.rss", image: #imageLiteral(resourceName: "WSJ")),
    Feed(id: 18, name: "ESPN",          link: "https://flipboard.com/@espn.rss", image: #imageLiteral(resourceName: "ESPN")),
    Feed(id: 21, name: "Recode",        link: "https://flipboard.com/@recode.rss", image: #imageLiteral(resourceName: "Recode")),
    Feed(id: 22, name: "SB Nation",     link: "https://flipboard.com/@SBNation.rss", image: #imageLiteral(resourceName: "SBNation")),
    Feed(id: 23, name: "Vox",           link: "https://flipboard.com/@Vox.rss", image: #imageLiteral(resourceName: "Vox")),
    Feed(id: 26, name: "CBS Sports",    link: "https://flipboard.com/@cbssports.rss", image: #imageLiteral(resourceName: "CBS")),
    Feed(id: 27, name: "NBC",           link: "https://flipboard.com/@NBCNews.rss", image: #imageLiteral(resourceName: "NBC")),
    Feed(id: 28, name: "Bleacher Report", link: "https://flipboard.com/@BleacherReport.rss", image: #imageLiteral(resourceName: "BleacherReport")),
    Feed(id: 4, name: "USA Today",      link: "https://flipboard.com/@USAToday.rss", image: #imageLiteral(resourceName: "USAToday")),
    Feed(id: 30, name: "Bloomberg",      link: "https://flipboard.com/@bloomberg.rss", image: #imageLiteral(resourceName: "Bloomberg")),
    Feed(id: 31, name: "Business Insider",      link: "https://flipboard.com/@BusinessInsider.rss", image: #imageLiteral(resourceName: "BusinessInsider")),
    Feed(id: 32, name: "Yahoo News",      link: "https://flipboard.com/section/yahoo-news-pov3tocb0hs3r1dk.rss", image: #imageLiteral(resourceName: "YahooNews"))
]



//let rssFeeds = [npr, cnn, nytimes ,reuters, usatoday, apnews, ars, hackerNews, techcrunch, time, cnbc, cbsnews, abcnews, latimes, pbs, wallStreetJournal,bbc, theguardian,economist,economistBusiness, espn ]
//
//
//let atomFeeds = [theVerge, recode, sbnation, vox, fox]

//func sourceString(feed: String) -> String {
//    var source = ""
//    switch feed {
//    case npr:
//        source = "NPR"
//        break
//    case cnn:
//        source = "CNN"
//        break
//    case nytimes:
//        source = "NYTimes"
//        break
//    case reuters:
//        source = "Reuters"
//        break
//    case usatoday:
//        source = "USA Today"
//        break
//    case apnews:
//        source = "AP News"
//        break
//    case ars:
//        source = "ArsTechnica"
//        break
//    case hackerNews:
//        source = "Hacker News"
//        break
//    case techcrunch:
//        source = "TechCrunch"
//        break
//    case time:
//        source = "Time"
//        break
//    case fox:
//        source = "Fox"
//        break
//    case cnbc:
//        source = "CNBC"
//        break
//    case cbsnews:
//        source = "CBS"
//        break
//    case abcnews:
//        source = "ABC"
//        break
//    case latimes:
//        source = "LA Times"
//        break
//    case theVerge:
//        source = "The Verge"
//    case recode:
//        source = "ReCode"
//    case sbnation:
//        source = "SB Nation"
//    case vox:
//        source = "Vox"
//    case wallStreetJournal:
//        source = "WSJ"
//    case pbs:
//        source = "PBS"
//    case bbc:
//        source = "BBC"
//    case theguardian:
//        source = "theGuardian"
//    case economist, economistBusiness:
//        source = "Economist"
//    case espn:
//        source = "ESPN"
//    default:
//        source = ""
//    }
//    return source
//}


