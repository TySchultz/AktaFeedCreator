//
//  SourcesViewController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/5/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import FeedKit
import RxSwift
import FontAwesome_swift
class SourcesViewController: UIViewController {
    let spinToken = "spinner"
    let feedbackToken = "feedBackField"

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        
        self.view.backgroundColor = UIColor.white
        self.collectionView.backgroundColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func pushSettingsView() {
        let settingsView = SettingsViewController()
        self.navigationController?.pushViewController(settingsView, animated: true)
    }
    
    func reloadCollection() {
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    func configure() {
        self.title = "Channels"
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - IGListAdapterDataSource
extension SourcesViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        let header        = SectionHeaderObject(title: "Channels", subtitle: "Channels have stories from a single source")
        var objects : [ListDiffable] = [feedbackToken as ListDiffable] //+ atomFeeds
        objects.append(header)
        let feeds = rssFeeds.sorted(by: { (left, right) -> Bool in
            return left.name.uppercased() < right.name.uppercased()
        })
        for feed in feeds {
            objects.append(feed as ListDiffable)
        }
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is Feed {
            return SourcesListSectionController()
        }else if object is SectionHeaderObject {
            return SectionHeaderListController()
        }else if let obj = object as? String, obj == feedbackToken {
            return FeedbackFieldListSectionController()
        }
        return spinnerSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
