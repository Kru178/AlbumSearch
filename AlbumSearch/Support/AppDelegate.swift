//
//  AppDelegate.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 08.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    let tabbarController = UITabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let albumsVC = storyboard.instantiateViewController(withIdentifier: "AlbumsVC") as! AlbumsViewController
        let albumsNavController = UINavigationController.init(rootViewController: albumsVC)
        albumsNavController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search-7"), tag: 0)
        let historyVC = storyboard.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryViewController
        let historyNavController = UINavigationController.init(rootViewController: historyVC)
        historyNavController.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "clock-7"), tag: 1)
        
        tabbarController.viewControllers = [albumsNavController, historyNavController]
        tabbarController.tabBar.tintColor = .black
        
        self.window?.rootViewController = tabbarController
        
        return true
    }
}
