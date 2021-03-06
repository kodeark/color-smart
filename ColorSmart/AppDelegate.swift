//
//  AppDelegate.swift
//  ColorSmart
//
//  Created by David on 17/05/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var containerViewController:ContainerViewController?
    
    var dbFilePath: NSString = NSString()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.makeKeyAndVisible();
        
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
        
        checkIfUnderMaintenance()

    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - DATABASE
    
    func initializeDb() -> Bool {
        
        let DATABASE_RESOURCE_NAME = "colorSmart"
        let DATABASE_RESOURCE_TYPE = "sqlite"
        let DATABASE_FILE_NAME = DATABASE_RESOURCE_NAME + "." + DATABASE_RESOURCE_TYPE
        
        let documentFolderPath = getDocumentsDirectory()
        
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
                
                if let databaseStructureFilePath = NSBundle.mainBundle().pathForResource("Database", ofType: ""){

                    do{
                        
                        let createQuery = try NSString(contentsOfFile: databaseStructureFilePath, usedEncoding: nil) as String
                        let addSuccessful = db.executeStatements(createQuery)
                        db.close()
                        if !addSuccessful {
                            print("insert failed: \(db.lastErrorMessage())")
                            return false
                        }
                    }
                    catch let error as NSError{
                        
                        print("create query failed : \(error.localizedDescription)")
                    }
                    
                }else{
                    print("Database file not found")
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
    
    // MARK: - Maintenace check
    
    func checkIfUnderMaintenance(){
        
        // Display overlay view
        let appOverlayViewController = AppOverlayViewController()
        window!.rootViewController = appOverlayViewController
        appOverlayViewController.message = "Loading..."
        
        //Call Maintenance url
        var configuration = Configuration()
        let urlString = configuration.environment.baseURL + "/urls?app=" + deviceType()
        
        Alamofire.request(.GET, urlString,parameters: nil, encoding: .URL)
            .validate().responseJSON{ (response) -> Void in
                
                guard response.result.isSuccess else {
                    
                    print("Error while checking maintenance: \(response.result.error)")
                    appOverlayViewController.message = "Oops! something went wrong."
                    return
                }
                
                guard let responseJSON = response.result.value as? [String:AnyObject],
                    status = responseJSON["maintenance"] as? Bool,
                    accessories = responseJSON["accessories"] as? [String:AnyObject] else{
                    
                    print("Malformed data received from maintenance service")
                    return
                }
                
                if status {
                    appOverlayViewController.message = (accessories["maintenanceMsg"] as? String)!
                    return
                }
                
//                let filename = getDocumentsDirectory().stringByAppendingPathComponent("maintenance.json")
//                let data = NSKeyedArchiver.archivedDataWithRootObject(responseJSON)
//                data.writeToFile(filename, atomically: true)

                if self.initializeDb() {
                    NSLog("Successful db copy")
                }
                
                if self.containerViewController == nil{
                    self.containerViewController = ContainerViewController()
                }
                
                let appData = AppData()
                appData.webUrls = (responseJSON["H5Urls"] as? [String : AnyObject])!
                appData.nativeUrls = (accessories["nativeUrls"] as? [String : AnyObject])!
                
                self.containerViewController?.appData = appData
                
                self.window?.rootViewController = self.containerViewController
            
        }
    }
    

}

