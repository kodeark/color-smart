//
//  AppDelegate.swift
//  ColorSmart
//
//  Created by David on 17/05/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var containerViewController:ContainerViewController?
    var dbFilePath: NSString = NSString()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
        containerViewController = ContainerViewController()
        
        window!.rootViewController = containerViewController
        window!.makeKeyAndVisible();
        
        if self.initializeDb() {
            NSLog("Successful db copy")
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - DATABASE
    
    func initializeDb() -> Bool {
        
        let DATABASE_RESOURCE_NAME = "colorSmart"
        let DATABASE_RESOURCE_TYPE = "sqlite"
        let DATABASE_FILE_NAME = DATABASE_RESOURCE_NAME + "." + DATABASE_RESOURCE_TYPE
        
        let documentFolderPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let dbfile = "/" + DATABASE_FILE_NAME;
        
        self.dbFilePath = documentFolderPath.stringByAppendingString(dbfile)
        
        let filemanager = NSFileManager.defaultManager()
        if (!filemanager.fileExistsAtPath(self.dbFilePath as String) ) {
            
            let backupDbPath = NSBundle.mainBundle().pathForResource(DATABASE_RESOURCE_NAME, ofType: DATABASE_RESOURCE_TYPE)
            
            if (backupDbPath == nil) {
                
                let db:FMDatabase = FMDatabase(path: self.dbFilePath as String)
                if !db.open() {
                    NSLog("error opening db")
                }
                let createQuery = "create table test_tb(id integer primary key autoincrement, name text)" //TODO: Will be modified with actual query string
                let addSuccessful = db.executeStatements(createQuery)
                db.close()
                if !addSuccessful {
                    print("insert failed: \(db.lastErrorMessage())")
                    return false
                }

            } else {
                
                do{
                
                    try filemanager.copyItemAtPath(backupDbPath!, toPath: dbFilePath as String)
                    
                }catch let error as NSError{
                
                    print("copy failed: \(error.localizedDescription)")
                    return false
                }
                
                
            }
        }
        
        return true
        
    }
    

}

