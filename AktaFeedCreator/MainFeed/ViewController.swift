//
//  ViewController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 12/28/17.
//  Copyright © 2017 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import FeedKit
import RxSwift
import FontAwesome_swift
class ViewController: UIViewController {

    let spinToken = "spinner"

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.downloadUpdatedTime()
      
        self.view.backgroundColor = UIColor.white
        self.collectionView.backgroundColor = UIColor.white
        
        self.refresher = UIRefreshControl()
        self.collectionView.alwaysBounceVertical = true
        self.refresher.tintColor = aktaPurple
        self.refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.collectionView.addSubview(refresher)
 
//        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = aktaPurple

        
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    var refresher:UIRefreshControl!
    func reloadCollection() {
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    var sampleData :[FeedCollection] = []
    
    func configure() {
        self.title = "Today"
        self.view.backgroundColor = UIColor.clear
        self.collectionView.backgroundColor = UIColor.clear
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
    @objc func refreshData() {
        DispatchQueue.global(qos: .background).async {
            let downloader = Downloader()
            downloader.pullFromTodaysCollections { (collection) in
                DispatchQueue.main.async {
                    self.sampleData = collection
                    self.reloadCollection()
                    self.refresher.endRefreshing()
                }
            }
        }
    }
    
    func downloadUpdatedTime() {
        let downloader = Downloader()
        downloader.getLastUploadDate { (date) in
            print(date)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    var index = 1
}

// MARK: - IGListAdapterDataSource
extension ViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var objects : [ListDiffable] = []
        guard sampleData.count > 0 else { return objects }
        objects.append(SectionHeaderObject(title: "Today's Collections", subtitle: "Collections are groups of similar articles") as ListDiffable)
        for collection in sampleData[0...19] {
            objects.append(collection)
        }
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is FeedCollection {
            let feedCollectionList = FeedCollectionListController()
            return feedCollectionList
        }else if object is SectionHeaderObject {
            return SectionHeaderListController()
        }
        return spinnerSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        label.textAlignment = .center
        label.text = "Pull to refresh feed"
        label.font = HeadlineAppFont()
        label.alpha = 0.2
        return label
    }
}



final class MainFeed: NSObject {
    
    let collections: [FeedCollection]
    let id: Int
    
    init(collections: [FeedCollection], id: Int) {
        self.collections = collections
        self.id = id
    }
}

extension MainFeed: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
}

