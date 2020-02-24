//
//  AppDelegate.swift
//  MySwiftTemplate
//
//  Created by apple on 10/5/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /*
        let itemIcon1 = UIApplicationShortcutIcon.init(templateImageName: "AIcon")
        let item1 = UIApplicationShortcutItem.init(type: "type1", localizedTitle: "title1", localizedSubtitle: "subTitle1", icon: itemIcon1, userInfo: nil)

        let itemIcon2 = UIApplicationShortcutIcon.init(templateImageName: "rightIcon")
        let item2 = UIApplicationShortcutItem.init(type: "type2", localizedTitle: "title2", localizedSubtitle: "subTitle2", icon: itemIcon2, userInfo: nil)

        let itemIcon3 = UIApplicationShortcutIcon.init(type: .add)
        let item3 = UIApplicationShortcutItem.init(type: "type3", localizedTitle: "title3", localizedSubtitle: "subTitle3", icon: itemIcon3, userInfo: nil)

        let itemIcon4 = UIApplicationShortcutIcon.init(type: .alarm)
        let item4 = UIApplicationShortcutItem.init(type: "type4", localizedTitle: "title4", localizedSubtitle: "subTitle4", icon: itemIcon4, userInfo: nil)

        UIApplication.shared.shortcutItems = [item1, item2, item3, item4]
        */
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
         print(shortcutItem)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "MySwiftTemplate")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if #available(iOS 10.0, *) {
            let context = persistentContainer.viewContext
            
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
}
