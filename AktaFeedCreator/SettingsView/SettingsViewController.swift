//
//  SettingsViewController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/3/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import FeedKit
import RxSwift
import FontAwesome_swift
import StatusAlert
class SettingsViewController: UIViewController {
    
    let spinToken = "spinner"
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    let downloadingObjectsSubject = BehaviorSubject(value: "Settings")
    
    var downloadStrings : [StringOutput] = []
    
    var isDownloading = false
    var count = 0
    
    let disposeBag = DisposeBag()
    
    let downloadString = StringOutput(text: "Download", id: 0)
    let organizeFeeds = StringOutput(text: "Organize Feeds", id: 1)
    let ssh = StringOutput(text: "ssh", id: 2)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        
        self.view.backgroundColor = UIColor.white
        self.collectionView.backgroundColor = UIColor.white
        
        downloadingObjectsSubject.subscribe { (event) in
            guard event.element != "Settings" else { return }
            if let feedName = event.element {
                if feedName == "COMPLETED" {
                    DispatchQueue.main.async {
                        self.isDownloading = false
                        self.reload()
                        self.showAlert(icon: .check, title: "Finished", subTitle: "Finished Downloading Raw Sources")
                    }
                }else {
                    DispatchQueue.main.async {
                        
                    }
                }
            }
        }.disposed(by: self.disposeBag)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func reload() {
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    var sampleData :[FeedCollection] = []
    
    func configure() {
        self.title = "Settings"
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
    
    @objc func organizeData() {
        self.isDownloading = true
        self.reload()
        let downloader = Downloader()
        downloader.pull { (collection) in   	
            self.sampleData = collection
            self.isDownloading = false
            self.reload()
        }
    }
    
    @objc func downloadData() {
        self.isDownloading = true
        self.reload()
        self.showAlert(icon: .check, title: "Downloading", subTitle: "Collecting articles from sources...")
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            let downloader = Downloader()
            downloader.downloadFeedObjects(subject : self.downloadingObjectsSubject)
            DispatchQueue.main.async {
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showAlert( icon : FontAwesome, title: String, subTitle: String ) {
        let faImage = UIImage.fontAwesomeIcon(name: icon, textColor: aktaGreen.withAlphaComponent(0.7), size: CGSize(width: 32, height: 32), backgroundColor: UIColor.clear)
        let statusAlert = StatusAlert.instantiate(withImage: faImage,
                                                  title: title,
                                                  message: subTitle,
                                                  canBePickedOrDismissed: true)
        // Presenting created instance
        statusAlert.showInKeyWindow()
    }
}

// MARK: - IGListAdapterDataSource
extension SettingsViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var objects : [ListDiffable] = [SectionHeaderObject(title: "Manage Data", subtitle: "Create and manage data for Akta") as ListDiffable]
        if self.isDownloading {
            objects.append(spinToken as ListDiffable)
        }
        objects.append(downloadString as ListDiffable)
        objects.append(organizeFeeds as ListDiffable)
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let e = object as? StringOutput {
            let settingsController = SettingsButtonListSectionController()
            if e.text == "Download" {
                settingsController.icon = .download
            }else {
                settingsController.icon = .compress
            }
            return settingsController
        }else if object is SectionHeaderObject {
            return SectionHeaderListController()
        }
        return spinnerSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
