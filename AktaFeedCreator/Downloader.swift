//
//  Downloader.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 12/28/17.
//  Copyright © 2017 Ty Schultz. All rights reserved.
//

import UIKit
import FeedKit
import Foundation
import Alamofire
import FirebaseCommunity
import RxSwift
import SwiftDate
class Downloader: NSObject {
    
    var allItems : [FeedItem] = []
    var allCollections : [FeedCollection] = []

    func downloadFeedObjects(subject : BehaviorSubject<String>){
        
        Auth.auth().signIn(withEmail: "ty@bluebookcasedesign.com", password: "tymakesawesomeapps") { (user, error) in
        }
        let feedItemsRef = Database.database().reference().child("Feed Items")
        feedItemsRef.setValue("")
        
        let sourceCollectionsRef = Database.database().reference().child("SourceCollections")
        sourceCollectionsRef.setValue("")
        
        for feed in rssFeeds as [Feed]{
            getSingleFeedRSS(feed: feed, subject: subject)
        }

        calculateCollections()
        pushRawItems(subject:subject)
        pushSourceItems(items: self.allItems)
    }
    
    var count = 0
    
    func getSingleFeedRSS(feed : Feed, subject : BehaviorSubject<String>) {
        subject.onNext("Downloading: " + feed.name)
     
        let feedURL = URL(string: feed.link)!
        let parser = FeedParser(URL: feedURL) // or FeedParser(data: data)
        guard let result = parser?.parse() else {
            subject.onNext("parser error: \(feed.name)")
            print("parser error: \(feed.name)")
            return
        }
        guard let serverFeed = result.rssFeed, result.isSuccess else {
            subject.onNext("feed creation error")
            print("feed creation error: \(feed.name)")
            return
        }
        
        guard let items = serverFeed.items else {
            subject.onNext("Could not get items")
            return
        }
        
        var sourceItems :[FeedItem] = []
        for item in items {
            
            let title = item.title ?? ""
            let source = feed.name
            let author = item.author ?? ""
            let link = item.link ?? ""
            let articleDescription = item.description ?? ""
            var imageLink = ""
            if let content = item.media?.mediaContents {
                imageLink = content[0].attributes?.url ?? ""
            }
            var category = ""
            if let itemCategory = item.categories {
                category = itemCategory.first?.value ?? ""
            }
            let feedItem = FeedItem(id: "", title: title, source: source, link: link, author: author, category: category, imageLink: imageLink, articleDescription: articleDescription)
            self.allItems.append(feedItem)
            sourceItems.append(feedItem)
        }
        
        print(feed.name)
        print(String(items.count))
    }
    
//    func getSingleFeedAtom(feed : Feed, subject : BehaviorSubject<String> ) {
//        subject.onNext("Downloading: " + feed.name)
//        let feedURL = URL(string: feed.link)!
//        let parser = FeedParser(URL: feedURL) // or FeedParser(data: data)
//        guard let result = parser?.parse() else {
//            print("parser error: \(feed.name)")
//            return
//        }
//        guard let serverFeed = result.atomFeed, result.isSuccess else {
//            subject.onNext("feed creation error")
//            print("feed creation error: \(feed.name)")
//            return
//        }
//
//        guard let items = serverFeed.entries else {
//            subject.onNext("Could not get items")
//            print("Could not get items: \(feed.name)")
//            return
//        }
//
//        var sourceItems :[FeedItem] = []
//        for item in items {
//            let feedItem = FeedItem(id: "", title: item.title ?? "", source: feed.name, link: item.id ?? "")
//            self.allItems.append(feedItem)
//            sourceItems.append(feedItem)
//        }
//    }
//
    func calculateCollections(){
        allCollections.sort { (left, right) -> Bool in
                return left.feedItems.count > right.feedItems.count
        }
    }

    func compareWords(collectionTokens : [String], itemTokens : [String]) -> Bool {
        print(collectionTokens)
        let new = collectionTokens.filter { (token) -> Bool in
            return itemTokens.contains(token)
        }
        if new.count > 4 {
            print(new)
            return true
        }
        return false
    }
    
    func pushRawItems(subject : BehaviorSubject<String>) {
        Auth.auth().signIn(withEmail: "ty@bluebookcasedesign.com", password: "tymakesawesomeapps") { (user, error) in
            
        }
        let ref = Database.database().reference().child("Feed Items")
        ref.removeValue()
        var titles : [Any] = []
        for (index,feed) in allItems.enumerated() {
            var single = feedToDict(feed: feed)
            let e = ref.childByAutoId()
            print(e.key)
            feed.id = e.key
            e.setValue(single)
            titles.append(single)
        }
        subject.onNext("COMPLETED")
    }
    
    func pushSourceItems(items : [FeedItem]) {
        Auth.auth().signIn(withEmail: "ty@bluebookcasedesign.com", password: "tymakesawesomeapps") { (user, error) in
            
        }
        var ref = Database.database().reference().child("SourceCollections")
        let items = items.sorted { (left, right) -> Bool in
            return left.sourceName > right.sourceName
        }
        guard let firstItem = items.first else { return}
        var currentSource = firstItem.sourceName
        var allSourceItems : [String : [String : Any]] = [:]
        var singleSourceItems : [String : Any] = [:]
        for (index,feed) in allItems.enumerated() {
            if currentSource != feed.sourceName {
                allSourceItems[currentSource] = singleSourceItems
                currentSource = feed.sourceName
                singleSourceItems = [:]
            }
            singleSourceItems[feed.id] = feedToDict(feed: feed)
        }
        ref.setValue(allSourceItems)
    }
    
    func pushCollections() {
        Auth.auth().signIn(withEmail: "ty@bluebookcasedesign.com", password: "tymakesawesomeapps") { (user, error) in
            
        }
        
        var collections : [String: Any] = [:]
        for collection in self.allCollections{
            collections[collection.id] = collectionToDict(collection: collection)
        }
        let ref = Database.database().reference().child("Feed Collections")
        ref.setValue("")
        ref.setValue(collections)
        
        updateUploadDate()
    }
    
    func updateSingleCollection(collection: FeedCollection) {
        Auth.auth().signIn(withEmail: "ty@bluebookcasedesign.com", password: "tymakesawesomeapps") { (user, error) in
        }
        let ref = Database.database().reference().child("Feed Collections").child(collection.id)
        ref.setValue(collectionToDict(collection: collection))
    }
    
    func deleteCollection(collection: FeedCollection) {
        Auth.auth().signIn(withEmail: "ty@bluebookcasedesign.com", password: "tymakesawesomeapps") { (user, error) in
        }
        let ref = Database.database().reference().child("Feed Collections").child(collection.id)
        ref.removeValue()
    }
    
    
    func uploadSuggestion(sourceSuggestion: String) {
        Auth.auth().signIn(withEmail: "ty@bluebookcasedesign.com", password: "tymakesawesomeapps") { (user, error) in
        }
        let ref = Database.database().reference().child("Source Suggestions").childByAutoId()
        ref.setValue(sourceSuggestion)
    }
    
    
    func updateUploadDate() {
        Auth.auth().signIn(withEmail: "ty@bluebookcasedesign.com", password: "tymakesawesomeapps") { (user, error) in
        }
        let ref = Database.database().reference().child("Upload Dates").child("Last Feed Creation")
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        
        let dateString = formatter.string(from: Date.init())
        ref.setValue(dateString)
    }
    
    func combineCollections(first : FeedCollection, second : FeedCollection) {
        
        for feedItem in second.feedItems {
            first.feedItems.append(feedItem)
        }
        Auth.auth().signIn(withEmail: "ty@bluebookcasedesign.com", password: "tymakesawesomeapps") { (user, error) in
        }
        
        let ref = Database.database().reference().child("Feed Collections")
        let firstRef = ref.child(first.id)
        firstRef.setValue(collectionToDict(collection: first))
        
        let secondRef = ref.child(second.id)
        secondRef.removeValue()
    }
}

//Pull
extension Downloader {
    func pull(completion: @escaping (_ feedList: [FeedCollection])->()){
        Auth.auth().signIn(withEmail: "ty@bluebookcasedesign.com", password: "tymakesawesomeapps") { (user, error) in
            
        }
       
        var ref = Database.database().reference().child("Feed Collections")
        ref.setValue("")
        
        ref = Database.database().reference().child("Python Feed Collections")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary {
                for (key,val) in value as! [String:NSArray]{
                    var feedItems:[FeedItem] = []
                    for item in val {
                        if let dict = item as? [String:String] {
                            feedItems.append(self.dictToFeed(dict: dict))
                        }
                    }
                    let first = val[0] as!  [String:String]
                    var sources :[String] = []
                    feedItems = feedItems.filter({ (item) -> Bool in
                        if sources.contains(item.sourceName) {
                            return false
                        }else {
                            sources.append(item.sourceName)
                            return true
                        }
                    })
                    let category = feedItems.first?.category
                    self.allCollections.append(FeedCollection(title: first["title"]!, source: first["source"]!, items: feedItems, id: key, category: category!, upVotes: 0))
                }
            }
            self.allCollections.sort { (left, right) -> Bool in
                return left.feedItems.count > right.feedItems.count
            }
            self.pushCollections()
            completion(self.allCollections)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func pullFromTodaysCollections(completion: @escaping (_ feedList: [FeedCollection])->()){
        var ref = Database.database().reference().child("Feed Collections")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary {
                for (key,val) in value as! [String:[String:Any]]{
                    var feedItems:[FeedItem] = []
                    if let items = val["feedItems"] as? NSArray {
                        for item in items {
                            if let dict = item as? [String:String] {
                                feedItems.append(self.dictToFeed(dict: dict))
                            }
                        }
                    }
                    if let title = val["title"] as? String, let source = val["source"] as? String, let category = val["category"] as? String, let upvotes = val["upVotes"] as? Int {
                        self.allCollections.append(FeedCollection(title: title, source: source, items: feedItems, id: key, category: category, upVotes: upvotes))
                    }
                }
            }
            self.allCollections.sort { (left, right) -> Bool in
                return left.feedItems.count > right.feedItems.count
            }
            completion(self.allCollections)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func pullSingleSource(feed: Feed, completion: @escaping (_ feedList: SourceCollection)->()){
        var ref = Database.database().reference().child("SourceCollections").child(feed.name)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            var sourceCollection : SourceCollection = SourceCollection(source: feed.name, items: [], id: feed.name)
            guard let value = snapshot.value as? NSDictionary else { completion(sourceCollection); return}
            var feedItems:[FeedItem] = []
            for (key,item) in value {
                if let dict = item as? [String:String] {
                    sourceCollection.feedItems.append(self.dictToFeed(dict: dict))
                }
            }
            completion(sourceCollection)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getLastUploadDate(completion: @escaping (_ date: String)->()){

        var ref = Database.database().reference().child("Upload Dates").child("Last Feed Creation")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            guard let value = snapshot.value as? String else { completion(""); return }
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .medium
            let d = formatter.date(from: value)!
            

            completion(value)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

//Serialize
extension Downloader {
    
    func dictToFeed(dict : [String:String] ) -> FeedItem {
        let id =  dict["id"] ?? ""
        let title =  dict["title"] ?? ""
        let source =  dict["source"] ?? ""
        let author =  dict["author"] ?? ""
        let link =  dict["link"] ?? ""
        let imageLink =  dict["imageLink"] ?? ""
        let category =  dict["category"] ?? ""
        let articleDescription =  dict["articleDescription"] ?? ""
        return FeedItem(id: id, title: title, source: source, link: link, author: author, category: category, imageLink: imageLink,articleDescription: articleDescription)
    }
    
    func feedToDict(feed : FeedItem) -> [String:String] {
        return [
            "id": feed.id,
            "title" : feed.title,
            "source" : feed.sourceName,
            "link" : feed.link,
            "category" : feed.category,
            "author" : feed.author,
            "imageLink" : feed.imageLink,
            "articleDescription" : feed.articleDescription
        ]
    }
    
    func collectionToDict(collection : FeedCollection) -> [String : Any] {
        return [
            "upVotes" : collection.upVotes,
            "title" : collection.articleTitle,
            "source" : collection.mainSource,
            "category" : collection.category,
            "feedItems" : collection.feedItems.map({ (feed) -> [String:String] in
                return self.feedToDict(feed: feed)
            })
        ]
    }
    
    
}
