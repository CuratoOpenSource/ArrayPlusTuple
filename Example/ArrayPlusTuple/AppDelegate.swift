//
//  AppDelegate.swift
//  ArrayPlusTuple
//
//  Created by mennolovink on 06/02/2018.
//  Copyright (c) 2018 mennolovink. All rights reserved.
//

import UIKit
import ArrayPlusTuple

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        let tuple1 = [1, 2, "three"].tuple
        
        let tuple2 = [1, 2, "three"].tuple as? (Int, Int, String)
        
        
        return true
    }
}

