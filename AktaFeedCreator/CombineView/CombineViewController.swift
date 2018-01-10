//
//  CombineViewController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import FeedKit
import RxSwift
import FontAwesome_swift
import StatusAlert
class CombineViewController: UIViewController {
    
    let spinToken = "spinner"
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    let feedSubject : BehaviorSubject<FeedCollection> =  BehaviorSubject(value: FeedCollection())
    var firstCollection : FeedCollection?
    var secondCollection : FeedCollection?
    
    let disposeBag = DisposeBag()

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
        
        //self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = aktaPurple
        
        
        feedSubject.subscribe { (event) in
            guard let collection = event.element else { return }
            guard collection.id != "99999" else { return }
            if self.collectionSelected == 0 {
                self.firstCollection = collection
                self.collectionSelected = 1
            }else {
                self.secondCollection = collection
                self.showCombineAlert()
            }
        }.disposed(by: self.disposeBag)
    }
    
    func showCombineAlert() {
        guard let first = self.firstCollection, let second = self.secondCollection else { return }
        let alertController = UIAlertController(title: "Remove Source?", message: first.articleTitle + "\n\n" + second.articleTitle, preferredStyle: .actionSheet)
        self.collectionSelected = 0

        let  promoteButton = UIAlertAction(title: "Combine Collections", style: .destructive, handler: { (action) -> Void in
            // Creating StatusAlert instance
            let faImage = UIImage.fontAwesomeIcon(name: .checkCircleO, textColor: aktaGreen.withAlphaComponent(0.7), size: CGSize(width: 32, height: 32), backgroundColor: UIColor.clear)
            let statusAlert = StatusAlert.instantiate(withImage: faImage,
                                                      title: "Collections Combined",
                                                      message: "Refreshing the feed now.",
                                                      canBePickedOrDismissed: true)
            // Presenting created instance
            statusAlert.showInKeyWindow()
            let d = Downloader()
            d.combineCollections(first: first, second: second)
            self.refreshData()
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            self.refreshData()
        })
        
        alertController.addAction(promoteButton)
        alertController.addAction(cancelButton)
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }
    
    var collectionSelected = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    var refresher:UIRefreshControl!
    func reloadCollection() {
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    var sampleData :[FeedCollection] = []
    
    func configure() {
        self.title = "Combine"
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
extension CombineViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var objects : [ListDiffable] = []
        guard sampleData.count > 0 else { return objects }
        objects.append(SectionHeaderObject(title: "Combine Collections", subtitle: "Combine similar collections to organize the data") as ListDiffable)
        for collection in sampleData[0...19] {
            objects.append(collection)
        }
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is FeedCollection {
            let feedCollectionList = CombineListSectionController()
            feedCollectionList.feedSubject = self.feedSubject
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
