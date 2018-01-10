//
//  FeedCollectionDetailController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/2/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//


import UIKit
import IGListKit
import FeedKit
import RxSwift

class FeedCollectionDetailController: UIViewController {
    
    let spinToken = "spinner"
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    var feedCollection : FeedCollection = FeedCollection(title: "", source: "", items: [], id: "", category: "", upVotes: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        
        self.view.backgroundColor = UIColor.white
        self.collectionView.backgroundColor = UIColor.white
        
        self.feedCollection.viewed = true 
        
//        let button = UIButton(type: .custom)
//        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
//        button.setTitle(String.fontAwesomeIcon(name: .cloudUpload), for: .normal)
//        button.setTitleColor(aktaPurple, for: .normal)
//        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        button.addTarget(self, action: #selector(upload), for: .touchUpInside)
//        let item1 = UIBarButtonItem(customView: button)
//        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
    }
    
    func reload() {
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    func configure() {
        self.title = String(feedCollection.feedItems.count) + " Articles"
        self.view.backgroundColor = UIColor.clear
        self.collectionView.backgroundColor = UIColor.clear
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    func upload() {
        let downloader = Downloader()
        downloader.updateSingleCollection(collection: self.feedCollection)
    }
    
    func promote(feedItem : FeedItem) {
        self.feedCollection.articleTitle = feedItem.title
        self.feedCollection.mainSource = feedItem.sourceName
        self.feedCollection.category = feedItem.category
        let downloader = Downloader()
        downloader.updateSingleCollection(collection: self.feedCollection)
        self.reload()
    }
    
    func deleteCollection() {
        let downloader = Downloader()
        downloader.deleteCollection(collection: self.feedCollection)
        self.navigationController?.popViewController(animated: true)
    }
    
    func combineCollection() {
        let downloader = Downloader()
        downloader.deleteCollection(collection: self.feedCollection)
        self.navigationController?.popViewController(animated: true)
    }
    
    func removeItem(feedItem : FeedItem) {
        print(self.feedCollection.feedItems.count)
        self.feedCollection.feedItems = self.feedCollection.feedItems.filter({ (item) -> Bool in
            return item != feedItem
        })
        print(self.feedCollection.feedItems.count)
        reload()
        upload()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - IGListAdapterDataSource
extension FeedCollectionDetailController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var objects : [ListDiffable] = [self.feedCollection as ListDiffable]
        for item in self.feedCollection.feedItems {
            objects.append(item as ListDiffable)
        }
        objects.append(StringOutput(text: "Delete Collection", id: 0) as ListDiffable)
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is FeedItem {
            return FeedItemListSectionController()
        }else if object is FeedCollection {
            return EditCollectionListSectionController()
        }else if let e = object as? StringOutput {
            if e.id == 0 {
                return DeleteCollectionListSectionController()
            }else {
                return CombineCollectionListSectionController()
            }
        }
        return spinnerSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

