//
//  SourceFeedViewController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/5/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
class SourceFeedViewController: UIViewController {
    let spinToken = "spinner"
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        
        downloadSource()
        self.view.backgroundColor = UIColor.white
        self.collectionView.backgroundColor = UIColor.white
        
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        button.setTitle(String.fontAwesomeIcon(name: .cog), for: .normal)
        button.setTitleColor(aktaPurple, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(pushSettingsView), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: button)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
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
    
    var sampleData : SourceCollection = SourceCollection(source: "", items: [], id: "")
    var feed : Feed = Feed(id: 0, name: "", link: "", image: #imageLiteral(resourceName: "XButton"))
    
    func downloadSource() {
        DispatchQueue.global(qos: .background).async {
            let downloader = Downloader()
            downloader.pullSingleSource(feed: self.feed, completion: { (collection) in
                DispatchQueue.main.async {
                    self.sampleData = collection
                    self.reloadCollection()
                }
            })
        }
    }

    func configure() {
        self.title = self.feed.name
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
extension SourceFeedViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        return [sampleData as ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is SourceCollection {
            return SourceDetailListController()
        }
        return spinnerSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
