//
//  MainTabBarController.swift
//  AktaFeedCreator
//
//  Created by Ty Schultz on 1/10/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import UIKit
import FontAwesome_swift
class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.tintColor = aktaPurple
        

        let mainFeed = ViewController()
        let sourcesView = SourcesViewController()
        let settingsView = SettingsViewController()
        let combineView = CombineViewController()
        
        
        setTabBar(controller: mainFeed, faIcon: .tasks, title: "Feed")
        setTabBar(controller: sourcesView, faIcon: .book, title: "Sources")
        setTabBar(controller: combineView, faIcon: .compress, title: "Combine")
        setTabBar(controller: settingsView, faIcon: .cogs, title: "Settings")

        let viewControllerList = [ UINavigationController(rootViewController: mainFeed),
                                   UINavigationController(rootViewController: sourcesView),
                                   UINavigationController(rootViewController: combineView),
                                   UINavigationController(rootViewController: settingsView)]
        self.viewControllers = viewControllerList
        // Do any additional setup after loading the view.
    }
    
    func setTabBar(controller : UIViewController, faIcon : FontAwesome, title: String ) {
        // The following statement is what you need
        let tabImage = UIImage.fontAwesomeIcon(name: faIcon, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        let tabImageSelected = UIImage.fontAwesomeIcon(name: faIcon, textColor: aktaPurple, size: CGSize(width: 30, height: 30))
        var customTabBarItem:UITabBarItem = UITabBarItem(title: title, image: tabImage, selectedImage: tabImageSelected)
        controller.tabBarItem = customTabBarItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
